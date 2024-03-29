---
title: Ruby и многозадачность
category: [ tech, programming, ruby, pub, samag ]
description: В статье рассматриваются основные средства работы с потоками (threads) и процессами в языке и стандартной библиотеке Ruby.
tags:
  - многопоточность
  - оптимизация
  - многозадачность
image: _src/2015/04/samag/screen-multitask.png
recommend: true
---
[Оригинал этой статьи опубликован в журнале «Системный администратор» №3 (136) за март 2014][samag].

-----

{% image @_src/samag/136.gif figure right width=158px fig_style="padding: 5px;" link="http://samag.ru/archive/article/2645" %}

<div class="note">
**В статье рассматриваются основные средства работы с потоками (threads) и процессами в языке и стандартной библиотеке Ruby**

Немного о терминологии: англоязычный термин «thread» на русский переводится в двух вариантах — как «поток» и как «нить».
Второй вариант точнее и не вызывает неоднозначности с потоками данных (streams), однако первый уже прижился в качестве основного.
Кроме того, есть еще производные термины и варианты вроде «многонитевость» (или «многонитность»), но они мне не встречались и,
честно говоря, режут глаз. Поэтому я буду использовать «поток».
</div>

Прежде, чем перейти к описаниям имеющегося инструментария, хотелось бы заметить, что Ruby создавался не как специальный язык
параллельного программирования, при этом во время его создания и становления многозадачность уже стала привычной и необходимой.
Из этих двух посылок, в об­щем-то, можно вывести текущую картину: никаких специфических концепций мы в нем не увидим, только
поддержку привычной для всех языков общего назначения модели с некоторыми нюансами реализации.

<!--more-->


## Многопоточность

Потоки позволяют программисту распараллелить выполнение задачи в рамках одного процесса. Это дает заметный выигрыш в двух основных
случаях: во-первых, когда есть аппаратные ресурсы для параллельных вычислений, т.е. многоядерная или многопроцессорная архитектура
(что для современных компьютеров норма), и во-вторых, когда какие-то подзадачи вынуждены тратить время на ожидание внешних ресурсов,
будь то дисковая подсистема, сеть, или действия пользователя.

Плохая новость в том, что в действительности потоки Ruby не параллельны, и выигрыша от многоядерности нам получить не удастся.
Несмотря на то, что актуальные версии интерпретатора используют потоки операционной системы, управление ими построено так, что
в определенный момент времени выполняется только один поток. В старых версиях (по 1.8.7 включительно) использовались так называемые
«зеленые» потоки, исполняющиеся в рамках одного системного, в новых — действует механизм GIL (global interpreter lock). Хорошей же
новостью можно считать то, что этот механизм защищает от некоторых (но не всех) потенциальных конфликтов между потоками.
Ниже о синхронизации еще поговорим, а пока отметим, что второй выигрыш — в случае ожидания внешних ресурсов — нам остается вполне
доступен, таким образом, польза от использования потоков в Ruby безусловно есть.

Работа с потоками в Ruby в основном сосредоточена в классе `Thread` — в самом простом случае мы создаем объект этого класса из блока
(или множество объектов) и ждем завершения[^gist].

{% highlight ruby %}
puts 'begin'

th = Thread.new do
  (1..3).each { |i| puts i }
end

# sleep 0
puts '---'

th.join

puts 'end'
{% endhighlight%}

Результат будет такой:

{% highlight console %}
$ ruby demo01.rb
begin
---
1
2
3
end
{% endhighlight %}

Если же мы раскомментируем строчку «`sleep 0`», положение строки с дефисами относительно цифр станет непредсказуемым,
а если вместо ноля напишем «`1`», или даже «`0.1`», дефисы будут стабильно выводиться после тройки, поскольку поток
полностью отработает раньше.

Что еще можно сделать с потоком, кроме как запустить его, и смиренно дождаться завершения (именно это делает метод `join`)?
Можно его приостановить (метод класса `Thread.stop`, вызываемый внутри потока), «разбудить», т.е. продолжить выполнение
с момента остановки (`wakeup`), прекратить, не дожидаясь окончания работы (`terminate`)... Такой пример:

{% highlight ruby %}
th = Thread.new do
  puts 'started'
  Thread.stop
  puts 'continued'
  sleep 100
  puts 'finished'
end

sleep 0.1
puts 'wakeup'
th.wakeup
sleep 0
puts 'terminate'
th.terminate
th.join
{% endhighlight %}

Даст следующий вывод:

{% highlight console %}
$ ruby demo02.rb
started
wakeup
continued
terminate
{% endhighlight %}

Причем, если мы закомментируем строку «`sleep 0`», то до «`continued`» дело может и не дойти.

### Обмен данными между потоками

*Во-первых,* мы можем передавать блоку аргументы при создании потока:

{% highlight ruby %}
Thread.new 1, 2, 3 { |a, b, c| ... }
{% endhighlight %}

*Во-вторых,* в Ruby любой код возвращает какое-то значение, и результат выполнения блока мы вполне можем получить —
для этого нужно использовать метод `value` вместо `join`.

*В-третьих,* блок, из которого создается поток, как и любой другой, образует замыкание, т.е. в нем можно обращаться
к любым данным, доступным в месте его объявления[^context]. Однако здесь нужно помнить о том, что разные потоки могут
обращаться к одним и тем же данным в произвольном порядке.

От одновременного обращения двух потоков к одной переменной нас защищает GIL, о котором было сказано выше,
он же делает многие (но не все) стандартные методы стандартных классов атомарными, но этого недостаточно.
Сколько раз выведет «`true`» следующий код?

{% highlight ruby %}
flag = true

5.times do
  Thread.new do
    puts 'true' if flag
    flag = false
  end
end

Thread.list.each do |th|
  if th != Thread.current
    th.join
  end
end
{% endhighlight %}

Правильный ответ: непредсказуемо, если запустить скрипт достаточно много раз, можно увидеть все варианты от одного до пяти.
Хотя проверка флага и присвоение ему значения сами по себе атомарны и не вызывают конфликтов, *между ними* легко может произойти
переключение между потоками.

Самый простой способ обеспечить синхронизацию — использовать метод `Thread.exclusive`, в предыдущем примере это бы выглядело так:

{% highlight ruby %}
5.times do
  Thread.new do
    Thread.exclusive do
      puts 'true' if flag
      flag = false
    end
  end
end
{% endhighlight %}

В более сложных случаях, когда у нас, например, две переменные, обращение к каждой из которых нужно синхронизировать
независимо друг от друга, следует использовать объекты класса `Mutex` и их метод `synchronize`.

{% highlight ruby %}
alpha = true
alpha_m = Mutex.new
beta = true
beta_m = Mutex.new

5.times do
  Thread.new do
    alpha_m.synchronize do
      puts 'alpha' if alpha
      alpha = false
    end
    beta_m.synchronize do
      puts 'beta' if beta
      beta = false
    end
  end
end
{% endhighlight %}

Собственно, `Thread.exclusive` делает то же самое, но при этом использует один и тот же объект класса `Mutex` на все случаи.

Кроме такой безусловной синхронизации объекты `Mutex` позволяют и более гибко работать с блокировками — в каких-то случаях
не дожидаться освобождения заблокированного объекта, а выполнить другие действия (например, вывести сообщение об ошибке).
А еще ручное блокирование/разблокирование дает простор для глупых ошибок по невнимательности, поэтому я бы не рекомендовал
им пользоваться без особой на то необходимости.

*В-четвертых,* мы можем получать и устанавливать так называемые переменные потока посредством методов `thread_variable_get`/`set`.

{% highlight ruby %}
th = Thread.new do
  sleep 0.1
  p Thread.current.thread_variable_get 'alpha'
end

th.thread_variable_set 'alpha', :alpha

th.join
{% endhighlight %}

Сюда же отнесем обращение к переменным, принадлежащим текущему «волокну» (fiber) потока — пример выше можно переписать так:

{% highlight ruby %}
th = Thread.new do
  sleep 0.1
  p Thread.current['alpha']
end

th['alpha'] = :alpha

th.join
{% endhighlight %}

Это короче и наглядней, но надо помнить, что в общем случае «волокна» могут меняться.

И, *в-пятых,* для потоков применимы описываемые ниже способы взаимодействия между процессами.

### Отступление о «волокнах»

«Волокна» (fibers) имеют косвенное отношение к теме статьи, но не упомянуть их нельзя, хотя бы
из-за вышеописанного обращения к fiber-local переменным. По сути это сопрограммы, переключение
между которыми происходит не средствами системы (или виртуальной машины), а вручную. Еще их можно
охарактеризовать как подпрограммы, выполнение которых при каждом вызове начинается с того момента,
на котором было остановлено в прошлый раз. Поясню примером:

{% highlight ruby %}
f = Fiber.new do
  current = Time.new
  loop do
    last = current
    current = Time.new
    Fiber.yield [last, current]
  end
end

5.times do
  p f.resume
  sleep 1
end
{% endhighlight %}

В результате получим последовательность пар значений времени предыдущего вызова и текущего.

В целом, это довольно экзотический инструмент, которому в явном виде не так-то просто найти
практическое применение.

### Дополнительно о потоках

Для группировки потоков существует класс `ThreadGroup`, который не предоставляет никакой особой функциональности,
кроме контроля за тем, что каждый поток принадлежит одной и только одной группе. Не добавленный ни в какую группу
явно, поток принадлежит `ThreadGroup::Default`.

Все классы, упомянутые выше, принадлежат ядру языка и загружаются автоматически, однако есть еще кое-какие возможности,
предоставляемые уже модулями стандартной библиотеки[^stdlib]. Так, «`require 'thread'`» предоставит нам классы `Queue`
и `SizedQueue`, с функциональностью очереди, как ясно из названия. Во втором случае объем очереди ограничен,
и при достижении ограничения помещение нового элемента будет дожидаться, пока другой поток освободит место.

Еще одна полезная библиотека («`require 'thwait'`» и класс `ThreadsWait`) позволяет ожидать завершения некоего набора
потоков, как всех вместе, так и по очереди.

## Процессы в Ruby

Собственно запуск программы на Ruby, как и на любом другом языке — есть запуск процесса. Который, в свою очередь,
может порождать дочерние и общаться как с ними, так и с совершенно независимыми от него. Ключевое отличие дочернего
процесса от потока — независимое адресное пространство — разные процессы не могут никаким образом обращаться к переменным
друг друга.

С точки зрения программиста дочерние процессы делятся на два принципиально разных вида: подпроцессы, порождаемые
из того же кода посредством `fork`, и внешние программы.

Как работает `fork`? В привычных языках, типа C — это функция, в родительском процессе возвращающая идентификатор дочернего,
а в дочернем — ноль. В Ruby можно ее использовать точно так же, однако более элегантно воспользоваться вариантом с блоком,
который и станет выполняться в дочернем процессе.

{% highlight ruby %}
pid = fork do
  3.times do |i|
    sleep 0.01
    puts "Child [#{Process.pid}]: #{i}"
  end
end

3.times do |i|
  sleep 0.01
  puts "Parent [#{Process.pid}]: #{i}"
end

Process.waitpid pid
{% endhighlight %}

Должен получиться примерно такой вывод:

{% highlight console %}
$ ruby demo09.rb
Parent [9032]: 0
Child [9034]: 0
Parent [9032]: 1
Child [9034]: 1
Parent [9032]: 2
Child [9034]: 2
{% endhighlight %}

Что здесь важно помнить, так это то, что хотя блок при `fork` и является замыканием, он получает доступ не к тому же окружению,
в котором определен, а *к его копии* на момент запуска. Таким образом обмен данными посредством внешних переменных невозможен,
а вопрос о синхронизации не имеет смысла.

Что касается внешних программ, то для их вызова служит несколько методов:

* `spawn` — асинхронный вызов, который нас и будет интересовать, возвращает идентификатор процесса;

* `system` — синхронный вызов (т.е. метод дожидается завершения), возвращает индикатор успешности вызова;

* `exec` — синхронный вызов, в случае неудачи вызывает исключение;

* <code>`command`</code> или `%x{command}` — самая простая форма — синхронный вызов, возвращает строку, соответствующую выводу программы.

Собственно, теме данной статьи соответствует только `spawn` как асинхронный. Замечу лишь, что `system` и `exec` используют те же
аргументы. Аргументы описываются следующим образом:

{% highlight text %}
spawn(‹env,› command ‹, args›*, ‹options›) → pid
{% endhighlight %}

Т.е. в начале идет необязательный параметр, устанавливающий дополнительные переменные окружения, затем команда, затем произвольное
количество необязательных же аргументов, и наконец, если последний параметр — хэш, из него берутся опции, позволяющие управлять
правами доступа, текущим каталогом и, самое главное, перенаправлениями ввода-вывода. В самом же простом случае достаточно указать
только команду.

### Сигналы

Процессы могут посылать друг другу сигналы и как-то на них реагировать. Вообще говоря, сигналы — это скорее механизм
для общения операционной системы с процессами, и большинство из них зарезервировано под специальные нужды, однако
кое-что можно задействовать и в прикладных целях. Выглядит это, например, так:

{% highlight ruby %}
child = fork do
  count = 0
  Signal.trap :USR1 do
    count += 1
    puts "Signal USR1: #{count}"
  end
  Signal.trap :TERM do
    puts 'Signal TERM'
    exit
  end
  sleep 1000
  puts 'Ooops!'
end

Signal.trap :CHLD do
  puts 'Child died.'
end

Process.kill :USR1, child
sleep 0.01
Process.kill :USR1, child
Process.kill :TERM, child

Process.wait
{% endhighlight %}

В результате должно получиться:

{% highlight console %}
$ ruby demo10.rb
Signal USR1: 1
Signal USR1: 2
Signal TERM
Child died.
{% endhighlight %}

Метод `Process.kill` посылает сигнал, а `Signal.trap` устанавливает обработчик сигнала. При этом нетрудно видеть,
что сигнал `CHLD` мы не посылали — его отправила система, уведомляя родительский процесс о завершении дочернего.
Отдельно стоит обратить внимание на строку «`sleep 0.01`» между двумя отправками. Если ее закомментировать,
то сигнал `USR1` будет получен дочерним процессом только один раз, поскольку на момент второй отправки первый
еще не будет обработан — сигналы поступают в очередь и уже имеющиеся там не добавляются.

К сожалению, посредством сигналов мы можем сообщить процессу только о наступлении некоторого события, без подробной
информации. А всю информацию между процессами нужно передавать средствами ввода-вывода.

### Каналы ввода-вывода

Общим способом для любых дочерних процессов будет перенаправление ввода-вывода посредством каналов (pipes).
Для внутренних подпроцессов это выглядит так:

{% highlight ruby %}
rd, wr = IO.pipe

child = fork do
  rd.close
  wr.write 'From Child'
  wr.close
end

wr.close
msg = rd.read
rd.close
p msg

Process.wait
{% endhighlight %}

Здесь существенно, что оба процесса первым делом закрывают ненужные «концы» канала. Если этого не сделать, то возможны
проблемы с некорректным определением конца файла.

В случае внешних команд все похоже, а «пишущий конец» канала передаем в специальном хэш-значении в последнем параметре spawn:

{% highlight ruby %}
rd, wr = IO.pipe

child = spawn "echo 'External Child'",
    [ STDERR, STDOUT ] => wr

wr.close
msg = rd.read
rd.close
p msg

Process.wait
{% endhighlight %}

В приведенных примерах использовалась передача данных только в одну сторону, что, конечно, необязательно. Можно создавать
произвольное количество каналов и назначать их как выводу, так и вводу.

### Сокеты

Сокеты — это совсем универсальный механизм взаимодействия произвольных программ между собою, в том числе и по сети.
Здесь уже не важно, как и где запускается процесс-собеседник, нужно только знать адрес и протокол обмена (формат данных).
Сам по себе стандарт сокетов довольно низкоуровневый, так что подробное описание и примеры заняли бы слишком много места.
Отмечу лишь, что инструменты работы с сокетами находятся в модуле `socket` стандартной библиотеки.

Кроме того, на сокетах основано взаимодействие уже максимального уровня — готовыми ruby-объектами в библиотеке dRuby,
о которой я писал в одной из предыдущих статей[^druby]. Здесь же стоит сказать, что dRuby позволяет обращаться к объекту
в другом процессе (и, возможно, на другой машине) как к локальному объекту Ruby со всеми его методами, свойствами и т.д.

## Применение

Подведем некоторые итоги.

При использовании *потоков* мы остаемся в рамках одного процесса, что определяет как плюсы, так и минусы: с одной стороны,
возможность использования общих переменных, с другой — взаимная зависимость. Дополнительный минус именно ruby-реализации —
глобальный блокировщик, из-за которого реально в любой момент времени выполняется только один поток. Следует однако понимать,
что GIL — это именно особенность реализации, а не языка, независимые реализации, такие как, например JRuby и Rubinius его
не имеют; не исключено, что и будущие версии «эталонного» Ruby изменят свое поведение.

Оптимальный сценарий использования — распараллеливание ожидания: работа с сетью, фоновые действия когда один из потоков ждет
и обрабатывает общение с пользователем, файловые операции. Основным средством взаимодействия между потоками является
использование общих переменных (не забывая про синхронизацию).

При запуске нескольких *процессов* получаем полный паралеллизм, а вот средства коммуникации приходится прописывать отдельно.

Соответственно, лучше всего такой сценарий поведет себя на максимально независимых задачах, малосвязных, обмен данными между
которыми можно свести к нескольким точкам. Взаимодействие строится на каналах ввода-вывода для дочерних процессов
и сокетах/dRuby для независимых.

[samag]: http://samag.ru/archive/article/2645

[^gist]: Полные тексты примеров находятся по адресу <https://gist.github.com/shikhalev/9198544>.
[^context]:  О блоках и замыканиях см. статью [«Блоки и контекст в Ruby»][ctx] в номере 1-2 этого года.
[^stdlib]: Подробную документацию на стандартную библиотеку можно найти по адресу <http://rubydoc.info/stdlib/> (англ.)
[^druby]: [«Распределенный Ruby»][drb] в декабрьском номере 2013 года.

[ctx]: {% link _posts/tech/2015/2015-04-01-ruby-context.md %}
[drb]: {% link _posts/tech/2015/2015-03-31-druby.md %}
