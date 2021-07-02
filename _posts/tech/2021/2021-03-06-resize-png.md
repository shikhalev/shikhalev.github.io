---
title: О ресайзе PNG на примерах
description: Способы ресайза картинок формата PNG — какие возможности у нас есть под Linux...
category: [ tech, soft, graphics ]
tags:
  - Linux
  - ImageMagick
  - GIMP
  - PNG
image: /assets/img/2021-03/resize/screen/source.png
recommend: true
---
{% include nova/image.html place="right" width=320 src="/assets/img/2021-03/resize/screen/source.png" title="Исходный скриншот диалога изменения размеров в GIMP" %}

Недавно мне задали такой вопрос:

> Иван, как-то довелось делать resize png-картинки в Gimp. По сравнению с Photoshop качество хуже. Можешь тут подсказать?

Фотошопа у меня нет, сравнить не могу, поэтому попробую рассмотреть вопрос несколько по другому — какие способы ресайза
мы имеем в Linux, пусть не «из коробки», но с минимальными трудозатратами. И что нам со всем этим богатством делать...

Сразу замечу, что выбор методов ресайза зависит не столько от формата, сколько от характера исходного изображения, так что все,
написанное ниже следует читать не как прямое руководство к действию, а как подсказку, в каком направлении копать.

Для начала, чтобы много не писать о сути проблемы вообще, сошлюсь на хабрастатью **[«Ликбез: методы ресайза изображений»][habr]**.
Она старая, но в плане основ и теории достаточно хорошо всё описывает. Более подробно, но на английском, можно почитать
на сайте ImageMagick: [«Resizing or Scaling»][resizing], [«Resampling Filters»][filters] и [«Re&shy;sam&shy;p&shy;ling by Nicolas Robidoux»][nicolas].
Если Photoshop не использует новейшие достижения искусственного интеллекта (это не шутка, различные AI-методы сейчас активно
применяются в обработке изображений), то правильный выбор фильтров и параметров,  будем надеяться, позволит получить результат
не хуже.

Что же касается формата PNG, то тут есть два соображения: во-первых, область применения — как правило, в PNG сохраняют
не фотографии, а изображения с чистыми цветами и четкими границами, а во-вторых, применимость его к финальному результату —
запросто можно при уменьшении картинки получить файл большего объема...

В общем, я взял два типичных, как мне кажется, случая, когда применяется именно этот формат: уменьшение скриншота (небольшое,
чтобы можно было говорить о читаемости) и увеличение иконки (тут — в разы). Экспериментировать я буду с при­ме­не­ни­ем **[GIMP][gimp]**
и **[ImageMagick][im]**.

**Disclaimer:** я не специалист в данной теме и все, что могу — потыкаться с точки зрения продвинутого юзера. Вы­ше­при­ве­ден­ные ссылки
могут стать отправной точкой для желающих разобраться по настоящему.

<!--more-->

## Уменьшение скриншота

Вот такой скриншот диалогового окна собственно GIMP и собственно изменения размеров. В оригинальном разрешении:

{% include nova/image.html place="center" width=415 src="/assets/img/2021-03/resize/screen/source.png" title="Исходный скриншот диалога изменения размеров в GIMP" %}

Ширина в оригинале — 415px. Ужимать будем до 320px, то есть, если очень грубо, на 20%. Точно такая же картинка вверху этого поста,
но сделанная движком браузера автоматически, что там, какие алгоритмы использованы — то мне неведомо.

### GIMP

GIMP предлагает пять вариантов интерполяции:

* Нет
* Линейная
* Кубическая
* Без гало
* Мало гало

Обратившись к [документации][gimp-doc], мы узнаем, что «Нет» — означает то, что обычно в источниках называется «метод ближайшего
соседа», а «линейная» и «кубическая» чаще называются «билинейной» и «бикубической» соответственно. Какой алгоритм используется
в двух последних вариантах — непонятно, судя по всему, подавление гало работает уже поверх собственно интерполяции... Так же возможно,
это какие-то модификации метода Lanczos, который был на их месте в старых версиях GIMP.

Пять вариантов достаточно мало, для того, чтобы все попробовать. Что же мы получим?

<div class="image-box">
{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/screen/gimp-none.png" caption="«Нет»" %}
{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/screen/gimp-linear.png" caption="«Линейная»" %}
{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/screen/gimp-cubic.png" caption="«Кубическая»" %}
</div>

Разницу между линейной и кубической уловить трудно, а последние два варианта — с гало и без — вообще от кубической на глаз не отличаются,
поэтому я их приводить не стал. Однако есть еще момент — размеры файлов. Для полноты картины я сравнил размеры не только файлов, которые
мне сохранил GIMP, но и их же после оптимизации программой **[optipng][optipng]**, которая не меняет пиксели, только перепаковывает.

{% highlight console %}
$ optipng -dir ./opt1/ -o7 source.png gimp-*.png
{% endhighlight%}

Получилось:

<table class="wide">

  <tbody><tr><th align="left">Файл</th><th align="center">Пиксели</th><th align="right">Байты</th><th align="right">Опт.</th></tr>

  <tr><td>source.png (исходный файл)</td><td align="center">415x361</td><td align="right">34K</td><td align="right">25K</td></tr>
  <tr><td>gimp-none.png (интерполяции нет)</td><td align="center">320x278</td><td align="right">25K</td><td align="right">16K</td></tr>
  <tr><td>gimp-linear.png</td><td align="center">320x278</td><td align="right">37K</td><td align="right">24K</td></tr>
  <tr><td>gimp-cubic.png</td><td align="center">320x278</td><td align="right">43K</td><td align="right">28K</td></tr>
  <tr><td>gimp-wo-galo.png (без гало)</td><td align="center">320x278</td><td align="right">40K</td><td align="right">27K</td></tr>
  <tr><td>gimp-s-galo.png (мало гало)</td><td align="center">320x278</td><td align="right">43K</td><td align="right">28K</td></tr>

</tbody></table>

Итак, мы отчетливо видим, что *уменьшение* скриншота в большинстве случаев *увеличивает* его размер. Что, впрочем, для формата PNG ожидаемо.
В целом, выводы можно сделать такие:

* Метод ближайшего соседа для уменьшения скриншотов не годится совсем — надписи не читаемы.

* Если качество линейной интерполяции нас устраивает, берем ее — она не только выполняется быстрее, но и дает результат меньшего объема.

* Если нам нужно максимальное качество, в GIMP выбираем вариант «Без гало» — за счет более резкой картинки (а именно это и делает подавление
  гало) файл лучше сжимается.

И помним, что *на другой исходной картинке результаты могут отличаться существенно*, так что стоит экспериментировать.

### ImageMagick

Хорошая новость заключается в том, что ImageMagick предоставляет больше вариантов ресайза. Плохая — в том, что их *намного* больше.
Команда `convert -list filter` на моей системе выдает список из 31 пункта. Но это еще не все — помимо оператора `-resize` есть еще
`-distort Resize`... Так что количество вариантов нужно умножать на два. А еще у многих фильтров есть настраиваемые параметры, а еще...
В общем, при углублении в тему документация ImageMagick подбрасывает все новые и новые уровни. В рамках этого поста я пройдусь
по верхам и параметры по умолчанию менять не буду.

Чтобы посмотреть все варианты, я воспользовался таким скриптом:

{% highlight bash %}
#!/bin/bash

filters=$(convert -list filter);

convert source.png -resize 320x ./im/0-resize-default.png
convert source.png -adaptive-resize 320x ./im/0-resize-adaptive.png
convert source.png -distort Resize 320x ./im/0-distort-default.png

for f in $filters; do
    convert source.png -filter $f -resize 320x ./im/1-resize-$f.png;
    convert source.png -filter $f -distort Resize 320x ./im/2-distort-$f.png
done;
{% endhighlight %}

На самом деле `-resize` без указания фильтра — это то же самое, что `-filter Mitchell -resize`, а `-distort Resize` —
`-filter Robidoux -distort Resize`. А вот `-adaptive-resize` — это отдельный режим, где обработка должна базироваться
на данных самой картинки (в документации тут не все ясно).

Итого у меня получилось 65(!) вариантов, все я, естественно, приводить не буду. Начнем с умолчательных:

<div class="image-box">
{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/screen/0-resize-default.png" caption="-resize" %}
{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/screen/0-distort-default.png" caption="-distort Resize" %}
{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/screen/0-resize-adaptive.png" caption="-adaptive-resize" %}
</div>

Далее проверим алгоритмы, которые должны соответствовать GIMP'овским (на самом деле не совсем).

<div class="image-box">
{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/screen/1-resize-Point.png" caption="-filter Point -resize" %}
{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/screen/2-distort-Point.png" caption="-filter Point -distort Resize" %}
</div>

`-filter Point` — это метод ближайшего соседа, как из него `-distort` получил нечто приемлемое — мне не очень понятно.

<div class="image-box">
{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/screen/1-resize-Triangle.png" caption="-filter Triangle -resize" %}
{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/screen/2-distort-Triangle.png" caption="-filter Triangle -distort Resize" %}

{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/screen/1-resize-Cubic.png" caption="-filter Cubic -resize" %}
{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/screen/2-distort-Cubic.png" caption="-filter Cubic -distort Resize" %}

{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/screen/1-resize-Lanczos2.png" caption="-filter Lanczos2 -resize" %}
{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/screen/2-distort-Lanczos2.png" caption="-filter Lanczos2 -distort Resize" %}

{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/screen/1-resize-Lanczos2Sharp.png" caption="-filter Lanczos2Sharp -resize" %}
{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/screen/2-distort-Lanczos2Sharp.png" caption="-filter Lanczos2Sharp -distort Resize" %}
</div>

Курьеза ради, и чтобы не создалось впечатления, что `-distort` всегда лучше, чем `-resize`, приведу варианты
с фильтром `Sinc`:

<div class="image-box">
{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/screen/1-resize-Sinc.png" caption="-filter Sinc -resize" %}
{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/screen/2-distort-Sinc.png" caption="-filter Sinc -distort Resize" %}
</div>

Завершу этот парад почти одинаковых картинок еще двумя фильтрами, которые показали приемлемые результаты
по размеру выходного файла.

<div class="image-box">
{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/screen/1-resize-Box.png" caption="-filter Box -resize" %}
{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/screen/2-distort-Box.png" caption="-filter Box -distort Resize" %}

{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/screen/1-resize-Hermite.png" caption="-filter Hermite -resize" %}
{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/screen/2-distort-Hermite.png" caption="-filter Hermite -distort Resize" %}
</div>

Теперь о размерах выходных файлов подробно (напомню, что исходный файл был 34K/25K):

<table class="wide">

<tbody><tr><th rowspan="2" align="left">Фильтр</th><th colspan="2" align="center">-resize</th><th colspan="2" align="center">-distort</th></tr>
<tr><th align="right">Байты</th><th align="right">Опт.</th><th align="right">Байты</th><th align="right">Опт.</th></tr>

<tr><td>-resize по умолчанию (Mitchell)</td><td align="right">43K</td><td align="right">29K</td><td colspan="2"></td></tr>
<tr><td>-distort по умолчанию (Robidoux)</td><td colspan="2"></td><td align="right">46K</td><td align="right">31K</td></tr>
<tr><td>-adaptive-resize</td><td align="right">36K</td><td align="right">23K</td><td colspan="2"></td></tr>

<tr><td>Point (ближайший сосед)</td><td align="right">25K</td><td align="right">17K</td><td align="right">37K</td><td align="right">24K</td></tr>
<tr><td>Triangle (линейная)</td><td align="right">39K</td><td align="right">26K</td><td align="right">42K</td><td align="right">28K</td></tr>
<tr><td>Cubic</td><td align="right">41K</td><td align="right">30K</td><td align="right">41K</td><td align="right">30K</td></tr>
<tr><td>Lanczos2</td><td align="right">47K</td><td align="right">31K</td><td align="right">47K</td><td align="right">32K</td></tr>
<tr><td>Lanczos2Sharp</td><td align="right">46K</td><td align="right">31K</td><td align="right">47K</td><td align="right">32K</td></tr>

<tr><td>Sinc</td><td align="right">67K</td><td align="right">46K</td><td align="right">67K</td><td align="right">39K</td></tr>
<tr><td>Box</td><td align="right">30K</td><td align="right">19K</td><td align="right">38K</td><td align="right">24K</td></tr>
<tr><td>Hermite</td><td align="right">39K</td><td align="right">25K</td><td align="right">40K</td><td align="right">26K</td></tr>

</tbody></table>

Выводы:

1. Если очень нужно уменьшать разрешение скриншота в PNG, то `-adaptive-resize`;
2. Но лучше вообще без этого обойтись, например, в вебе просто задав размеры у тега `IMG` и отдав масштабирование на откуп браузеру —
   трафик так можно сэкономить заметно.

{% include nova/image.html place="center" width=320 src="/assets/img/2021-03/resize/screen/source.png" caption="Исходная картинка, отмасштабированная браузером" title="Исходная картинка" %}

Это все, конечно, оносится только к случаям, подобным рассмотренному — когда размеры картинки ужимаются процентов на 20, чтобы,
скажем, вписаться в верстку. При сильном уменьшении про читаемость можно просто забыть и использовать простейшие методы, дающие
минимальный выходной файл. Кстати, на этот случай в ImageMagick есть еще и оператор `-thumbnail`, который работает еще быстрее
и грубее, чем `-resize`, а заодно выбрасывает всю метаинформацию.

## Увеличение иконки

Здесь я решил поиздеваться над иконкой Darktable, в оригинале — 64x64px.

{% include nova/image.html place="center" width=64 src="/assets/img/2021-03/resize/icon/darktable.png" alt="Иконка Darktable" %}

Будем увеличивать ее в 5 раз по линейным размерам, т.е. в 25 по площади — до 320x320px. Вот так это может сделать браузер:

{% include nova/image.html place="center" width=320 src="/assets/img/2021-03/resize/icon/darktable.png" alt="Иконка Darktable" img_style="width:320px;height:320px;" %}

### GIMP

А вот что нам предлагает GIMP:

<div class="image-box">
{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/icon/ico-gimp-none.png" caption="«Нет»" %}
{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/icon/ico-gimp-linear.png" caption="«Линейная»" %}
{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/icon/ico-gimp-wo-galo.png" caption="«Без гало»" %}
</div>

В режиме «Нет интерполяции» мы ожидаемо видим увеличение каждого пикселя, а в режиме «Линейная» — какое-то мыло. «Без гало»
дает нам мыло немножко по краям подшарпленое, что, кстати, наиболее похоже на вариант от браузера. Что же до оставшихся «Кубической»
и «Мало гало» — я не смог их отличить от «Линейной», даже быстро переключаясь с одной на другую.

<table class="wide">

  <tbody><tr><th align="left">Файл</th><th align="center">Пиксели</th><th align="right">Байты</th><th align="right">Опт.</th></tr>

  <tr><td>darktable.png (исходный файл)</td><td align="center">64x64</td><td align="right">6.2K</td><td align="right">6.2K</td></tr>
  <tr><td>gimp-none.png (интерполяции нет)</td><td align="center">320x320</td><td align="right">9.7K</td><td align="right">9.4K</td></tr>
  <tr><td>gimp-linear.png</td><td align="center">320x320</td><td align="right">68K</td><td align="right">68K</td></tr>
  <tr><td>gimp-cubic.png</td><td align="center">320x320</td><td align="right">75K</td><td align="right">75K</td></tr>
  <tr><td>gimp-wo-galo.png (без гало)</td><td align="center">320x320</td><td align="right">72K</td><td align="right">72K</td></tr>
  <tr><td>gimp-s-galo.png (мало гало)</td><td align="center">320x320</td><td align="right">76K</td><td align="right">75K</td></tr>

</tbody></table>

Выводы? Ну, для демонстрации пиксель-арта первый вариант может быть полезен. В остальных случаях браузер справляется не хуже, а объем меньше на порядок.

### ImageMagick

Скриптом, аналогичным предыдущему, удалось получить множество вариантов. Но ничего прямо так принципиально отличающегося в лучшую сторону.
Вероятно, без применения каких-нибудь AI-методов (т.е. распознавания и перерисовывания по сути) ничего принципиально улучшить и не получится.
Поэтому ограничусь только тремя примерами:

<div class="image-box">
{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/icon/0-resize-adaptive.png" caption="-adaptive-resize" %}
{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/icon/2-distort-Parzen.png" caption="-filter Parzen -distort Resize" %}
{% include nova/image.html place="inner" width=320 src="/assets/img/2021-03/resize/icon/2-distort-Sinc.png" caption="-filter Sinc -distort Resize" %}
</div>

Третий пример, если кто не догадался, вставлен забавы ради.

Как можно видеть, `-adaptive-resize` справляется, как минимум, не хуже GIMP'а... Что же по размерам файлов?

<table class="wide">

<tbody><tr><th rowspan="2" align="left">Фильтр</th><th colspan="2" align="center">-resize</th><th colspan="2" align="center">-distort</th></tr>
<tr><th align="right">Байты</th><th align="right">Опт.</th><th align="right">Байты</th><th align="right">Опт.</th></tr>

<tr><td>-resize по умолчанию (Mitchell)</td><td align="right">74K</td><td align="right">70K</td><td colspan="2"></td></tr>
<tr><td>-distort по умолчанию (Robidoux)</td><td colspan="2"></td><td align="right">77K</td><td align="right">73K</td></tr>
<tr><td>-adaptive-resize</td><td align="right">67K</td><td align="right">61K</td><td colspan="2"></td></tr>

<tr><td>Point (ближайший сосед)</td><td align="right">11K</td><td align="right">9.6K</td><td align="right">69K</td><td align="right">66K</td></tr>

<tr><td>Parzen</td><td align="right">88K</td><td align="right">84K</td><td align="right">78K</td><td align="right">74K</td></tr>
<tr><td>Sinc</td><td align="right">111K</td><td align="right">107K</td><td align="right">131K</td><td align="right">130K</td></tr>

</tbody></table>

Я не стал вставлять картинку с `-filter Point -resize`, поскольку она ожидаемо неотличима от того, что делает GIMP без интерполяции.
А еще такой же результат позволяют получить операторы `-sample` и `-scale`, только быстрее. Так же, как и `-thumbnail` — это максимально
упрощенные и тупые варианты ресайза.

## Итого

* Во-первых, формат PNG применяется для тех случаев, когда нам важно сохранить каждый пиксель как он есть. Т.е. любое масштабирование
  для таких картинок противопоказано. Именно для картинок как таковых, а не для формата. Если мы храним в PNG что-то хорошо масштабируемое,
  возможно, мы что-то делаем не так.

* Как только мы вместо резких переходов получаем сглаживание или размытие, файлы раздуваются непотребно. И это уже особенность формата, да,
  сжатие которого рассчитано на одноцветные области.

* *Если* всё же необходимо ресайзить PNG и именно в PNG, я бы, пожалуй, первым делом попробовал оператор `-adaptive-resize` пакета ImageMagick.
  А если результат не устраивает — прогнал бы скриптом прочие варианты фильтров. Можно, конечно, заморочиться и на подгонку их параметров,
  но боюсь, мои глаза не справятся с отловом тончайших отличий в огромном количестве файлов.

* GIMP, честно говоря, удивил бедностью возможностей — уж с десяток алгоритмов могли бы и завезти...

-----
**PS.** Для удобства оригиналы ссылкой: [скрин][source] и [значок][dt-source]. Желающие могут попробовать поиграть с их размерами
в разном другом софте, включая фотошоп.


[source]: /assets/img/2021-03/resize/screen/source.png "Исходный скриншот диалога изменения размеров в GIMP"

[sc-gimp-none]: /assets/img/2021-03/resize/screen/gimp-none.png
[sc-gimp-linear]: /assets/img/2021-03/resize/screen/gimp-linear.png
[sc-gimp-cubic]: /assets/img/2021-03/resize/screen/gimp-cubic.png

[sc-im-resize-default]: /assets/img/2021-03/resize/screen/0-resize-default.png
[sc-im-distort-default]: /assets/img/2021-03/resize/screen/0-distort-default.png
[sc-im-resize-adaptive]: /assets/img/2021-03/resize/screen/0-resize-adaptive.png
[sc-im-resize-Point]: /assets/img/2021-03/resize/screen/1-resize-Point.png
[sc-im-distort-Point]: /assets/img/2021-03/resize/screen/2-distort-Triangle.png
[sc-im-resize-Triangle]: /assets/img/2021-03/resize/screen/1-resize-Triangle.png
[sc-im-distort-Triangle]: /assets/img/2021-03/resize/screen/2-distort-Point.png
[sc-im-resize-Cubic]: /assets/img/2021-03/resize/screen/1-resize-Cubic.png
[sc-im-distort-Cubic]: /assets/img/2021-03/resize/screen/2-distort-Cubic.png
[sc-im-resize-Lanczos2]: /assets/img/2021-03/resize/screen/1-resize-Lanczos2.png
[sc-im-distort-Lanczos2]: /assets/img/2021-03/resize/screen/2-distort-Lanczos2.png
[sc-im-resize-Lanczos2Sharp]: /assets/img/2021-03/resize/screen/1-resize-Lanczos2Sharp.png
[sc-im-distort-Lanczos2Sharp]: /assets/img/2021-03/resize/screen/2-distort-Lanczos2Sharp.png
[sc-im-resize-Sinc]: /assets/img/2021-03/resize/screen/1-resize-Sinc.png
[sc-im-distort-Sinc]: /assets/img/2021-03/resize/screen/2-distort-Sinc.png
[sc-im-resize-Box]: /assets/img/2021-03/resize/screen/1-resize-Box.png
[sc-im-distort-Box]: /assets/img/2021-03/resize/screen/2-distort-Box.png
[sc-im-resize-Hermite]: /assets/img/2021-03/resize/screen/1-resize-Hermite.png
[sc-im-distort-Hermite]: /assets/img/2021-03/resize/screen/2-distort-Hermite.png

[dt-source]: /assets/img/2021-03/resize/icon/darktable.png
[dt-gimp-none]: /assets/img/2021-03/resize/icon/ico-gimp-none.png
[dt-gimp-linear]: /assets/img/2021-03/resize/icon/ico-gimp-linear.png
[dt-gimp-wo-galo]: /assets/img/2021-03/resize/icon/ico-gimp-wo-galo.png
[dt-im-resize-adaptive]: /assets/img/2021-03/resize/icon/0-resize-adaptive.png
[dt-im-distort-Parzen]: /assets/img/2021-03/resize/icon/2-distort-Parzen.png
[dt-im-distort-Sinc]: /assets/img/2021-03/resize/icon/2-distort-Sinc.png

[habr]: https://habr.com/ru/post/243285/ "Ликбез: методы ресайза изображений"
[resizing]: https://legacy.imagemagick.org/Usage/resize/
[filters]: https://legacy.imagemagick.org/Usage/filter/
[nicolas]: https://legacy.imagemagick.org/Usage/filter/nicolas/

[gimp]: https://www.gimp.org/
[im]: https://imagemagick.org/
[optipng]: http://optipng.sourceforge.net/

[gimp-doc]: https://docs.gimp.org/2.10/ru/gimp-tools-transform.html#gimp-tool-interpolation-methods
