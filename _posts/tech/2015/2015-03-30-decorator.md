---
layout: post
title: Декораторы в Ruby
description: Реализация паттерна «декоратор» на языке Ruby
category: [ tech, programming, ruby, pub, samag ]
tags:
  - метапрограммирование
image: /assets/img/2015-04/samag130.gif
---
<div class="right-box">
[![][cover]][samag]
</div>

[Оригинал этой статьи опубликован в журнале «Системный администратор» №9 (130) за сентябрь 2013][samag].

<div class="abstract" style="font-size: 90%">
Как известно, в языке Python существует красивый механизм декораторов, расширяющих функционал объекта без изменения
интерфейса. Это довольно мощное средство, попользоваться им удобно и приятно. Но вот проблема: наш язык
программирования — Ruby!

На самом деле никакой проблемы нет, и в Ruby достаточно возможностей, чтобы решать подобные задачи не менее эффективно,
чем в конкурирующих технологиях.

... ... ...

Универсальность всегда увеличивает сложность и накладные расходы. Так что мое мнение: жили мы без декораторов в Ruby
и еще поживем. Тем не менее сама методика декорирования кода, безусловно, заслуживает внимания и может с успехом применяться
в самых разных задачах.
</div>

<!--more-->

<hr>

<div class="sticker-right">
<u>Декоратор в общем смысле</u> — шаблон проектирования, предусматривающий динамическое подключение дополнительной
функциональности к некоторому уже имеющемуся объекту без изменения его интерфейса. Старая функциональность оказывается
как бы обернута в новую.

<u>Декоратор в языке программирования Python</u> — специальная синтаксическая конструкция, «оборачивающая» заданную
функцию с использованием ранее определенной функции-обертки. Оборачивающая функция принимает в качестве аргументов
заданную и, возможно, какие-то дополнительные параметры, которые в дальнейшем указываются при использовании декоратора,
и возвращает замещающую функцию.

Простой пример:

{%  highlight ruby %}
def log(f):

  def wrapped(*args, **kwargs):
    print(f)
    return f(*args, **kwargs)

  return wrapped

@log
def test():
  print("Test")

test()
{% endhighlight %}
</div>

Идея этой статьи навеяна постом на Хабре о декораторах в языке Python[^habr], а также некоторыми другими материалами в сети
на ту же тему. Авторы данных материалов явно гордятся такой возможностью языка, что прямо таки заставляет правоверного рубиста
выяснить, а как обстоят дела с аналогами в любимом языке. Конечно, надо понимать, что при всей близости по времени появления,
объектно-ориентированности и области применения, Python и Ruby все же разные языки, соответственно, аналоги получаются не один
к одному. Но можно говорить о схожих решениях схожих задач. Если мы откроем вышеупомянутый хабрапост, то увидим, в частности:

> «Для того, чтобы понять, как работают декораторы, в первую очередь следует осознать, что в Python'е функции — это тоже объекты»

И тут уже приходится остановиться: в Ruby, во-первых, нет функций, есть только методы, а во-вторых, методы объектами не являются.
Все плохо? Ничего подобного. Возможностей метапрограммирования в Ruby более чем достаточно для того, чтобы реализовать аналогичную
функциональность. Это и будет предметом настоящей статьи.

Пара слов о том, зачем это надо: способы применения могут быть самые разные — от ведения логов и замеров производительности
до проверки прав пользователя или каких-то еще сложных условий перед выполнением каждого действия. Причем, обрамлять своими
проверками мы можем любые методы, в том числе принадлежащие классам стандартной библиотеки языка, или библиотек, разрабатываемых
третьими лицами. Поскольку исходный код имеющихся библиотек не модифицируется, мы не создаем себе никаких препятствий к установке
обновлений и исправлений, что важно для проектов с длительным жизненным циклом.

## Блоки, методы и объекты Proc

{:.note}
*Здесь и далее я описываю сложные, но хорошо документированные, особенности языка применительно к основной теме статьи, кратко,
не всегда формально точно и, по возможности, просто. Для изучения языка лучше всего обратиться к более-менее официальным[^ppg]
и неофициальным[^wiki] руководствам.*

Итак, что мы имеем на уровне языка? Во-первых, это, конечно, *методы*. В принципе — те же функции, но определенные для класса
и исполняющиеся в контексте объекта. Замечу, что метод всегда определен для какого-то класса, даже если формально он задан
непосредственно объекту: так называемые синглтон-методы это методы так называемых синглтон-классов. Методы, определенные
в глобальном контексте принадлежат классу `Object`. С помощью метода `method` можно получить для данного метода объект класса
`Method` («Шишков, прости...»), который уже есть полноценный ruby-объект.

Во-вторых, это *блоки* — их можно рассматривать как анонимные функции, образующие замыкание с тем контекстом, в котором они
определены. При этом язык так устроен, что определяем блок мы всегда, передавая его в некий метод, где он доступен, помимо особых
средств языка, и как объект класса `Proc`.

Одним из таких методов, принимающих блоки, является метод класса `Module` `define_method`, который волшебным образом превращает
блок в метод. С другой стороны, объект класса `Proc`, а также любой объект, для которого определен метод `to_proc`, в том числе
и класса `Method`, может быть передан в качестве блока посредством префикса `&`.

Демонстрация:

{% highlight ruby %}
def show x, &block
  puts block.call(x)
end

def alpha x
  x + 1
end
a = method(:alpha)
puts a.inspect
puts a.call(0)

b = proc { |x| x + 2 }
puts b.inspect
Object.send :define_method, :beta, &b
puts beta(0)

show 10, &a
show 10, &b
show 10 do |x|
  x + 3
end
{% endhighlight %}

На выходе должны получить что-то вроде этого:

{%  highlight console %}
$ ruby deco2.rb
♯‹Method: Object♯alpha›
1
♯‹Proc:0x00000000af1298@deco1.rb:14›
2
11
12
13
{% endhighlight %}

Здесь мы из метода `alpha` получили объект, а метод `beta` наоборот, создали из объекта. «`Object.send :define_method`»
вместо «`Object.define_method`» пришлось использовать потому, что `define_method` — приватный.

Теперь, определившись, что у нас есть, можно перейти к рассмотрению того, что можно из этого сделать...

## Шаг первый — функция-обертка

Очевидно, что там, где в Python функция, принимающая и возвращающая функцию, у нас будет метод, принимающий объект класса
`Proc`, а лучше — для универсальности — блок, и возвращающий объект класса `Proc`.

Давайте напишем обертку-логгер:

{%  highlight ruby %}
def wrap &block
  proc do |*args, &blk|
    begin
      result = block.call *args, &blk
      $stderr.puts "OK: #{args.inspect}" +
          " => #{result.inspect}"
      result
    rescue Exception => e
      $stderr.puts "ERROR! #{args.inspect} => #{e.inspect}"
      raise
    end
  end
end
{% endhighlight %}

И протестируем ее:

{% highlight ruby %}
alpha = proc { |x, y| x / y }

a = wrap &alpha

z1 = a.call 4, 2
z2 = a.call 4, 0
{% endhighlight %}

Получаем (в предположении, что определение обертки и тестирующий код находятся в файле `deco2.rb`, как у меня[^gist]):

{% highlight console %}
$ ruby deco2.rb
OK: [4, 2] =› 2
ERROR! [4, 0] =› ♯‹ZeroDivisionError: divided by 0›
deco2.rb:16:in `/': divided by 0 (ZeroDivisionError)
        from deco2.rb:16:in `block in ‹main›'
        from deco2.rb:6:in `call'
        from deco2.rb:6:in `block in wrap'
        from deco2.rb:21:in `call'
        from deco2.rb:21:in `‹main›'
{% endhighlight %}

Здесь хорошо видно, что мы получили исключение, вывели информацию о нем и отправили его дальше по стеку вызовов.
Это сделано затем, чтобы и в плане исключений обертка вела себя так же, как исходная функция.

Чтобы в начале и конце у нас был метод, требуется добавить в общем-то немного:

{%  highlight ruby %}
def wrap_method name
  Object.send :define_method, name, &(wrap &(method name))
end
{% endhighlight %}

Получаем метод, создаем обертку и на ее основе переопределяем метод с тем же именем. Проверяем как-то так:

{% highlight ruby %}
def alpha x, y
  x / y
end

wrap_method :alpha

alpha 4, 2
alpha 4, 0
{% endhighlight %}

## Шаг второй — в правильном контексте

Примеры выше даны для глобального контекста, в котором, однако, на практике методы определяют редко. Нормальное
расположение методов — в контексте класса или модуля. Или попросту модуля, поскольку класс в данном случае есть
его разновидность (очень специфическая, но все же).

Поместим метод `wrap` в явном виде в класс `Object` (на самом деле, он и так там, просто сделаем определение более
ясным) и заставим его принимать не только блоки, но и непосредственно объекты класса `Method`, чтобы иметь доступ
к имени метода, а также класса `UnboundMethod`, чтобы оперировать методами, не привязанными к конкретному объекту.

{% highlight ruby %}
class Object

  private

  def wrap meth = nil, &block
    func = meth || block
    name = (meth && meth.name) || ''
    proc do |*args, &blk|
      if UnboundMethod === func
        func = func.bind self
      end
      begin
        result = func.call *args, &blk
        $stderr.puts "OK: #{self.inspect}.#{name}" +
            " #{args.inspect} => #{result.inspect}"
        result
      rescue Exception => e
        $stderr.puts "ERROR! #{self.inspect}.#{name}" +
            " #{args.inspect} => #{e.inspect}"
        raise
      end
    end
  end

  def wrap_singleton_method *names
    names.each do |name|
      define_singleton_method name, &wrap(method name)
    end
  end

end

class Module

  def wrap_method *names
    names.each do |name|
      define_method name, &wrap(instance_method name)
    end
  end

end
{% endhighlight %}

И попробуем:

{%  highlight ruby %}
class Fixnum

  wrap_method :+, :-

end

z0 = 4 + 2
z1 = 4 - 2

def mul x, y
  x * y
end

wrap_singleton_method :mul

z2 = mul 4, 2
{% endhighlight %}

Получим:

{%  highlight console %}
$ ruby deco4.rb
OK: 4.+ [2] =› 6
OK: 4.- [2] =› 2
OK: main.mul [4, 2] =› 8
{% endhighlight %}

Нетрудно заметить, что использование `wrap_method` выглядит весьма похоже на стандартные модификаторы `private`, `protected`
и `public`. Давайте еще усилим эту похожесть (а заодно и похожесть на python-декораторы) — при вызове без параметров, метод
будет действовать на все последующие определения. Модифицируем `wrap_method`:

{%  highlight ruby %}
def wrap_method *names
  if names.length != 0
    @ignore_wrap = true
    names.each do |name|
      define_method name, &wrap(instance_method name)
    end
    @ignore_wrap = false
  else
    ma = method :method_added
    define_singleton_method :method_added do |name|
      wrap_method name unless @ignore_wrap
      ma.call name if ma
    end
  end
end
{% endhighlight %}

Метод класса `Module` `method_added` вызывается при любом определении метода. Чтобы не уйти в бесконечный цикл, нам приходится
дополнительно ввести флаг, говорящий о том, что текущее определение — это наша обертка, которую заново оборачивать не нужно.

Кстати, здесь мы вместо того, чтобы перекрыть метод `method_added` создаем (опять же) над ним обертку. Сделано это затем, чтобы
нам не помешали его возможные переобъявления. Проверим на следующем коде:

{%  highlight ruby %}
class Alpha

  class << self

    def method_added name
      puts "method_added: #{name}"
    end

  end

  def alpha
    p :alpha
  end

  wrap_method

  def beta
    p :beta
  end

  def gamma
    p :gamma
  end

end

a = Alpha.new

a.alpha
a.beta
a.gamma
{% endhighlight %}

Должно получиться на выходе:

{% highlight console %}
$ ruby deco5.rb
method_added: alpha
method_added: beta
method_added: beta
method_added: gamma
method_added: gamma
:alpha
:beta
OK: ♯‹Alpha:0x00000001e7c510›.beta [] =› :beta
:gamma
OK: ♯‹Alpha:0x00000001e7c510›.gamma [] =› :gamma
{% endhighlight %}

Аналогично можно модифицировать и `wrap_singleton_method`, если очень хочется.

## Шаг третий — фабрика генераторов

Ну и наконец, давайте решим задачу в более-менее общем виде. Пусть у нас будет способ генерировать различные «декораторы»,
задав имя и блок, возвращающий `proc`-обертку. Блок будет принимать `UnboundMethod` и произвольные именованные параметры.
Только именованные, поскольку неименованный список мы будем вместе с ними передавать при вызове декоратора — это имена
декорируемых методов, как и в примерах выше. В python-декораторах так делать не принято, зато в Ruby подобное сплошь и рядом.

{:.note}
*Для упрощения и сокращения кода далее я использую синтаксическую конструкцию для задания именованных параметров,
которая появилась только в Ruby версии 2.0 (предыдущие примеры полностью работоспособны и в 1.9). Сделать тоже самое
в предыдущих версиях вполне реально, но несколько длиннее.*

Вот такое короткое определение:

{%  highlight ruby %}
class Module

  def decorator name, &wrapper
    define_singleton_method name do |*names, **opts|
      if names.length != 0
        @ignore_wrap = true
        names.each do |nm|
          define_method nm,
              &wrapper.call(instance_method(nm), **opts)
        end
        @ignore_wrap = false
      else
        ma = method :method_added
        define_singleton_method :method_added do |nm|
          send name, nm, **opts unless @ignore_wrap
          ma.call nm if ma
        end
      end
    end
  end

end
{% endhighlight %}

Прогоним тестовый пример:

{%  highlight ruby %}
$: << '.'

require 'deco'

class Alpha

  decorator :echo do |unbound, prefix: 'echo: ', **opts|
    proc do |*args, &blk|
      puts prefix + 'name = ' +
          unbound.name.inspect if opts[:name]
      puts prefix + 'args = ' + args.inspect if opts[:args]
      result = unbound.bind(self).call *args
      puts prefix + 'result = ' +
          result.inspect if opts[:result]
      result
    end
  end

  def alpha
    :alpha
  end

  echo :alpha, prefix: '', result: true

end

class Beta < Alpha

  def beta x
    "BETA: " + x.to_s
  end

  echo :beta, args: true, result: true

  echo args: true, name: true, result: true, prefix: '[*] '

  def gamma a, b, c
    a * b * c
  end

end

b = Beta.new

b.alpha
b.beta 1
b.gamma 1, 2, 3
{% endhighlight %}

И получим:

{% highlight console %}
$ ruby demo.rb
result = :alpha
echo: args = [1]
echo: result = "BETA: 1"
[*] name = :gamma
[*] args = [1, 2, 3]
[*] result = 6
{% endhighlight %}

## Идем дальше?

Как видим, все работает. Кроме того, определения декораторов прекрасно наследуются. Для дальнейшего развития можно
поработать над тем, чтобы они еще и «включались» при добавлении mixin-модуля, предусмотреть отмену и/или переключение
и так далее. Но... так уж ли все это нужно? Тем более, что есть не столь универсальный, зато очень простой и достаточный
в большинстве случаев способ сделать обертку:

{%  highlight ruby %}
class Fixnum

  alias :mul :*

  def * x
    result = mul x
    $stderr.puts "#{self} * #{x} = #{result}"
    result
  end

end
{% endhighlight %}

Универсальность всегда увеличивает сложность и накладные расходы. Так что лично мое мнение: жили мы без декораторов в Ru&shy;by,
и еще поживем. Тем не менее сама методика декорирования кода, безусловно, заслуживает внимания и может с успехом применяться
в самых разных задачах.

[cover]: /assets/img/2015-04/samag130.gif
[samag]: http://samag.ru/archive/article/2520


[^habr]: «Понимаем декораторы в Python'e, шаг за шагом», <http://habrahabr.ru/post/141411/> и [141501/](http://habrahabr.ru/post/141501/),
         перевод с английского — Владислав Степанов; оригинал: “What are Python decorators?”, Renaud Gaudin, <http://yeleman.com/what-are-python-decorators/>.

[^ppg]: Dave Thomas, with Chad Fowler and Andy Hunt, «Programming Ruby: The Pragmatic Programmers' Guide», бесплатная версия первого
        издания — <http://www.ruby-doc.org/docs/ProgrammingRuby/> [en].

[^wiki]: Викиучебник по Ruby, <http://ru.wikibooks.org/wiki/Ruby>.

[^gist]: Полные тексты всех примеров можно взять на GitHub Gist: <https://gist.github.com/shikhalev/6259566>.
