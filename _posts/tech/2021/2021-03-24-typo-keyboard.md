---
title: Ввод «типографских» символов с клавиатуры (ed. 2021)
description: >-
  Настройка клавиатуры в Linux для ввода различных символов, таких как, например, длинное тире,
  кавычки-ёлочки, знак копирайта и так далее. В редакции 2021 года.
category: [ tech, soft ]
tags:
  - Linux
  - клавиатура
  - символы
  - KDE
  - GNOME
  - Xfce
image: /assets/img/2021-03/typo/keyboard-layout.png
recommend: true
---
{% include image.liquid place="right" width=320 src="/assets/img/2021-03/typo/keyboard-layout.png" title="Раскладка клавиатуры с третьим и четвертым уровнями" %}

{:.note.italic}
Оригинал этого поста в «Технобложике» оказался самым популярным материалом — на него заходят и заходят
из поисковиков, ссылаются на форумах и так далее. Поэтому к его переносу я подошел максимально ответственно,
перепроверив все рекомендации в современных дистрибутивах и внеся дополнения. Таким образом, этот пост
получил некоторую добавочную ценность к оригиналу. Особенно совершенно новый раздел о том, как можно добавить
свои собственные символы в раскладку.

На эту тему в интернетах написано немало. Я лишь хочу в этом посте собрать и обобщить некоторую часть информации,
чтобы рекомендовать друзьям – новичкам в Linux. Итак, этот пост для тех, кто работает с текстом в Linux, дабы они
поняли свое счастье.

Вообще говоря, ввод каких бы то ни было символов с клавиатуры можно организовать разными путями, некоторые
из которых (например, определение собственной раскладки) доступны и в оффтопичной системе от MS. Однако, *удобных*
способов существенно меньше. Собственно, я буду говорить о двух, простых как в использовании, так и в настройке:
«третий уровень» и Compose Key.

<!--more-->

## Общие принципы

«Третий уровень»

: Это как бы дополнительный `[Shift]` — добавочный ряд символов на клавишах: нажимаете назначенную для этого клавишу
  вместе с какой-то алфавитно-цифровой и получаете специальный символ. Руки очень быстро «запоминают» такое сочетание.
  Использовать не сложнее, чем `[Shift]` оригинальный, разве что у того клавиши широкие на большинстве клавиатур...
  Причем можно зажать и назначенную нами клавишу третьего уровня (в дальнейшем — `[L3]`) и `[Shift]`, получив тем
  самым «четвертый уровень»... Но вряд ли это особо понадобится.

  Пример: длинное тире («—») вводится как `[L3]+[-]`.

Compose Key

: Тут принцип другой — нажимаете (и отпускаете) назначенную для этого клавишу, затем нажимаете последовательно несколько
  (две–три обычно) алфавитно-цифровых клавиш, чтобы получить их «сочетание». Например, значок копирайта («©») можно ввести
  так: `[Compose]→[o]→[c]` (а можно — `[Compose]→[c]→[o]`). Здесь я стрелочками подчеркиваю, что клавиши нажимаются
  последовательно, а не одновременно. Кстати, сами стрелочки я ввожу посредством `[Compose]→[-]→[>]`.

  {:.small.italic}
  Уточнение от 2021 года. Умолчательные сочетания клавиш могут различаться от дистрибутива к дистрибутиву и от версии
  к версии. Сейчас у меня сочетание `[Compose]→[o]→[c]` действительно выдает значок копирайта, но вот
  `[Com­po­se]→[c]→[o]` — уже другой символ — «ǒ». Кроме того, стрелочку вправо я сейчас предпочитаю вводить через
  третий уровень — `[L3]+[0]`, хотя вариант через Compose также рабочий.

Эти два способа совершенно друг другу не мешают. Лично я их использую оба, применяя Compose Key для тех символов, которые
отсутствуют в наборе «третьего уровня».

## Базовая настройка

### KDE 4 и 5

{% include image.liquid id="kde" place="right" width=320 src="/assets/img/2021-03/typo/kde.png" title="Модуль настройки клавиатуры в KDE" %}

У меня стоит версия KDE 4.5.4, в других версиях названия каких-то пунктов могут отличаться, но вряд ли существенно.

{:.note.italic}
Год 2021. Использую KDE 5, версия Plasma — 5.21.3, KDE Applications — 20.12.3. В от­но­ше­нии настройки клавиатуры по сути ничего
не поменялось — см. [иллюстрацию](#kde).

Итак, открываем «Параметры системы» и находим там раздел «Об&shy;о&shy;ру&shy;до&shy;ва&shy;ние» → «Устройства ввода» → «Кла­ви­а­ту­ра». Открываем вкладку
«До&shy;пол&shy;ни&shy;тель&shy;но». Если попалась непереведенная версия, по-английски это будет «System Set&shy;tings» → «Hardware» → «Input Devices» →
«Keyboard» → «Ad­van­ced». Там следует отметить (если еще не отмечена) галочку «Настроить параметры клавиатуры» («Configure
keyboard options»), после чего станут доступны собственно настройки. Нам понадобятся следующие:

* «Клавиша для выбора 3-го ряда» («Key to choose 3rd level») — нужно отметить один из вариантов. Лично я использую клавиши `[Win]`
  (те, на которых нарисован флажок MS), поскольку: а) их две, а мы помним, что настраиваем как бы дополнительный `[Shift]` — тоже парный;
  б) по-умолчанию никакой полезной нагрузки в Linux они не несут, соответственно, ничего нужного мы таким образом не испортим. В общем,
  мой выбор — «Любая клавиша Win» («Any Win key»).

  {:.small.italic}
  Сейчас у меня клавиатура с закосом под игровую, и справа вместо `[Win]` — ненужная мне `[Fn]`, на которую, увы, ничего не настроить.
  Поэтому в дополнение к вышесказанному отметил еще и правый `[Alt]` — все-таки очень привык к `L3` с обеих сторон.

* «Разные параметры совместимости» → «Включить дополнительные типографские символы» («Mis­cel­la­ne­ous com­pa­ti­bi­li­ty options» → «Enable extra
  ty­po­gra­phic characters»). Этим мы собственно «заполняем» подключенный предыдущим пунктом «третий уровень».

* «Клавиша пробела используется для ввода символа неразрывного пробела» → «Символ неразрывного пробела в третьем ряду,
  символ тонкого неразрывного пробела в четвёртом ряду» («Using space key to input non-breakable space character» →
  «Non-breakable space character at third level, thin non-breakable space character at fourth level»). Пробел, на котором
  запрещен разрыв строки принято использовать, например, после инициалов, а также перед тире. Установка данной опции позволит
  вводить его быстро и логично. Что же до тонкого неразрывного пробела... Использовать его не обязательно, однако по-хорошему
  для инициалов должен использоваться именно он. Сравним: «Ф. М. Достоевский» и «Ф. М. Достоевский» (не говоря уж об кошмарном,
  но часто используемом, варианте «Ф.М. Достоевский»). Еще его можно использовать между запятой/точкой и тире. Правда, эффект
  сильно зависит от шрифта, причем в шрифте может вообще не оказаться такого символа и мы получим на его месте знак вопроса
  или квадратик... Хотя в последнее время все шрифты (с которыми мне доводилось иметь дело) содержат подобные символы.

* «Положение клавиши Compose» («Compose key position»). Лично я в качестве `[Compose]` использую `[Caps Lock]`, поскольку
  ее штатное действие приносит исключительно вред. Если же вы не можете от нее отказаться, можно выбрать столь же бесполезную
  (однако, безвредную) `[Scroll Lock]`, хотя на мой взгляд, ее расположение не столь удобно.

Итого — нам понадобилось поставить четыре галочки.

### GNOME и Cinnamon

{% include image.liquid place="right" width=320 src="/assets/img/2021-03/typo/ubuntu.png" title="Настройка клавиатуры в Ubuntu" %}

В GNOME есть (должен быть) подобный модуль центра управления для настройки клавиатуры. Ввиду эстетического неприятия, сейчас GNOME
на моем компьютере отсутствует, а ставить его только ради того, чтобы посмотреть, как там настраивается раскладка клавиатуры — это уж
слишком. Ищите по ключевым словам «третий уровень», «типографские символы» и «Compose Key»...

<div class="note italic">
На этот раз я не поленился и посмотрел разные дистрибутивы и DE в виртуалках.
</div>

{% include image.liquid place="left" width=320 src="/assets/img/2021-03/typo/cinnamon.png" title="Настройка клавиатуры в среде Cinnamon (Linux Mint)" %}

<div class="note italic">
GNOME не подвел — «из коробки» там ничего нет, чтобы получить третий уровень и Compose, нужно ставить GNO&shy;ME Tweak Tool. Впрочем,
как я понимаю, это нужно практически для всего. Еще интересный момент, что настройка Compose Key («композиционной клавиши») вынесена
на первый экран настроек клавиатуры (см. скриншот справа), тогда как третий уровень нужно задавать в диалоговом окне, открывающемся
по кнопке «Дополнительные параметры раскладки».

А вот Cinnamon держит настройки вместе. И место это «Параметры системы» → «Клавиатура» → «Раскладки» → кнопка «Параметры...» — см. скриншот слева.

В общем-то, не проблема найти, все логично.
Галочки в списках в обеих системах те же самые, что и вышеописанные KDE-шные, так что см. предыдущий пункт.
</div>

### Xfce и все-все-все...

{% include image.liquid place="right" width=240 src="/assets/img/2021-03/typo/xfce.png" title="Настройки клавиатуры в среде Xfce" %}

Почему «и все-все-все...»? Потому что Xfce не умеет настраивать подобные средства — его возможности настройки клавиатуры
сильно ограничены... Поэтому сейчас мы рассмотрим универсальный для всех иксов способ настройки — через конфиги. Способ
именно что универсальный — у меня и KDE работает с заданными таким образом системными настройками, однако для его использования
нужно иметь доступ от root'а, да и конфиги править — это вам не галочки мышкой щелкать — это гораздо проще.

{:.note.italic}
Что ж, вот и хорошие новости: за прошедшие 10 лет Xfce таки расширил возможности настройки клавиатуры. Частично. Теперь можно
штатным средствами включить Compose Key, см. скриншот. А вот доступа к третьему уровню не прибавилось, таким образом настоящий
раздел актуальности не утратил.

Тут есть только одна загвоздка — расположение нужных настроек зависит от версии сервера иксов...

Как это выглядит у меня: отдельный файл `/etc/X11/xorg.conf.d/20-keyboard.conf` содержит следующее:

{% highlight conf %}
Section "InputClass"
  Identifier "Keyboard Defaults"
  MatchIsKeyboard "yes"
  Option "XkbLayout" "us,ru"
  Option "XkbOptions" "grp:alt_shift_toggle,grp_led:scroll,compose:caps,lv3:win_switch,nbsp:level3n,misc:typo"
EndSection
{% endhighlight %}

Эту секцию можно и просто вписать в файл `/etc/X11/xorg.conf`. Однако есть вероятность того, что это не сработает —
на старых версиях Xorg, насколько я помню, устройства по классам не фильтровались... В общем, если не получилось так,
то нужно отыскать в `/etc/X11/xorg.conf` строку `Option "XkbOptions"` и изменить ее значение на вышеуказанное.
Если же xorg-server работает с клавиатурой через HAL, то ему следует скормить файл `/etc/hal/fdi/policy/10-x11-input.fdi`,
о ко­то­ром я уже писал когда-то, добавив туда «`lv3:win_switch,nbsp:level3n,misc:typo`» в опции.

<!-- TODO: ссылка на пост про HAL и .fdi -->

Кроме указания всех этих опций так или иначе в параметрах X-сервера, придется их еще и активировать программой `setxkbmap`
(без каких-либо ключей или параметров). В Xfce ее просто нужно задать в автозапуск.

<div class="note italic">
И снова хорошие новости: ни в Xfce (по крайней мере в Xubuntu), ни в LXQt (Lubuntu соответственно), больше не надо ничего
прописывать в автозапуск — в Xfce следует отметить флажок «Использовать системные параметры», ну а LXQt и вовсе ничего такого
настраивать не умеет, и использует настройки Xorg без каких-либо флажков (точнее, не мешает их использовать).

Еще в Lubuntu обнаружился один момент — там окружение перехватывает клавишу `[Win]` и обрабатывает ее в духе Win­dows.
На третий уровень, получается, эти клавиши назначить нельзя. Но сам третий уровень работает, например, если назначить
правый `[Alt]`, или еще какую-нибудь клавишу, которую не жалко.
</div>

## Использование

Собственно, как этим пользоваться, я написал в самом начале. Ниже подробности — как ввести наиболее часто нужные символы.

### Третий уровень

<div class="note italic">
Вместо старой таблицы я наконец-то сделал красивую схему клавиатуры с третьим и четвертым уровнями. Самому такую памятку
давно хотелось, да все как-то руки не доходили. На <u>небуквенных</u> клавишах в верхней части слева — простое нажатие,
справа — с `[Shift]`, на <u>буквенных</u> — собственно буква в верхнем регистре, как обычно на самой клавиатуре изображается.
Нижний ряд везде (где оно есть): слева — третий уровень, т.е. при зажатой клавише `[L3]`, справа — четвертый, т.е.
`[Shift]+[L3]`. Желающие распечатать в максимальном качестве могут скачать [архив с SVG][zip].

Как я уже говорил, что-то может меняться от дистрибутива к дистрибутиву и от версии к версии. Сейчас у меня схема именно такая,
от текущей раскладки (rus/eng) она не зависит.
</div>

{% include image.liquid place="center" width=850 src="/assets/img/2021-03/typo/keyboard-layout.png" title="Раскладка клавиатуры с третьим и четвертым уровнями" %}

{:.note}
Некоторые символы, пожалуй, требуют пояснений, их-то я и вынесу в таблицу:

{:.coded}
|  Сочетание         | Сим. | Unicode               | Комментарий |
|:-------------------|:----:|:----------------------|:------------|
| `[L3]+[-]`         | `—`  | `U+2014 EM DASH`      | Длинное тире — собственно тире в русской пунктуации. |
| `[L3]+[Shift]+[-]` | `–`  | `U+2013 EN DASH`      | Короткое тире — в классической русской пунктуации не использовалось. Сейчас начинает применяться для диапазонов. |
| `[L3]+[P]`         | `´`  | `U+00B4 ACUTE ACCENT` | Это просто символ, не путать с `U-0301`, он же `[L3]+[A]`. |
| `[L3]+[Shift]+[P]` | `˝`  | `U+02DD DOUBLE ACUTE ACCENT`    | |
| `[L3]+[A]`         | _́    | `U+0301 COMBINING ACUTE ACCENT` | Знак ударе́ния. Ставится *над предыдущим символом*, а не на отдельное знакоместо. Для иллюстрации я поместил на картинке светло-серую букву «a», но вообще это может быть любой нормальный символ. |
| `[L3]+[D]`         | `°`  | `U+00B0 DEGREE SIGN`  | Знак градуса — на картинке это может быть не очень заметно, но размещается в верхней части строки. «Сегодня -5°C», например. |
| `[L3]+[J]`<br>`[L3]+[Shift]+[J]`<br>`[L3]+[K]`<br>`[L3]+[Shift]+[K]`<br>`[L3]+[L]`<br>`[L3]+[Shift]+[L]`  | `„`<br>`‚`<br>`“`<br>`‘`<br>`”`<br>`’` | `U+201E DOUBLE LOW-9 QUOTATION MARK`<br>`U+201A SINGLE LOW-9 QUOTATION MARK`<br>`U+201C LEFT DOUBLE QUOTATION MARK`<br>`U+2018 LEFT SINGLE QUOTATION MARK`<br>`U+201D RIGHT DOUBLE QUOTATION MARK`<br>`U+2019 RIGHT SINGLE QUOTATION MARK` | Это *правильные* символы кавычек-лапок, двойных и ординарных. Причем сочетание, соответствующее J-K, принято в русской пунктуации, а K-L — в английской (то есть русская закрывающая кавычка является английской открывающей). |
| `[L3]+[;]`<br>`[L3]+[']` | `‘`<br>`’` | `U+2018 LEFT SINGLE QUOTATION MARK`<br>`U+2019 RIGHT SINGLE QUOTATION MARK` | Да-да, дублируют символы из предыдущего блока, только на третьем уровне, а не на четвертом[^check]. |
| `[L3]+[Shift]+[;]` | `′` | `U+2032 PRIME` | Используется для обозначения угловых минут и футов[^feet]. |
| `[L3]+[Shift]+[']` | `″` | `U+2033 DOUBLE PRIME` | Используется для обозначения угловых секунд и дюймов. |
| `[L3]+[Shift]+[X]` | `⋅` | `U+22C5 DOT OPERATOR` | Это математический символ. Для умножения в формулах предпочтительно с позиций типографики использовать именно его, а не обычную звездочку или какую-то из множества центральных точек. |
| `[L3]+[M]`         | `−` | `U+2212 MINUS SIGN` | Знак минуса. Математический опять же. В отличие от обычного дефиса, к которому все привыкли, этот знак в шрифтах *должен* по высоте, ширине и толщине соответствовать знаку плюса. |
| `[L3]+[Shift]+[M]` | `•` | `U+2022 BULLET` | А этот символ в противоположность `U+22C5` не нужно использовать в математических формулах, а предназначен он для списков и прочего как маркер. |
| `[L3]+[ ]` | ` ` | `U+00A0 NO-BREAK SPACE` | Неразрывный пробел. |
| `[L3]+[Shift]+[ ]` | ` ` | `U+202F NARROW NO-BREAK SPACE` | Тонкий неразрывный пробел. |

{:.note.italic#bug}
Проверяя последний пункт, обнаружил баг в своей системе, но об этом [позже][fix].

### Compose Key

Тут вообще уйма разных сочетаний, я приведу только наиболее (на мой взгляд) полезные и не встречающиеся в предыдущей таблице.

{:.coded}
| Сочетание               | Сим. | Unicode | Комментарий |
|:------------------------|:----:|:--------|:------------|
| `[Compose]→[^]→[1]`     | `¹`  | `U+00B9 SUPERSCRIPT ONE` | Верхний индекс — так же работает для всех цифр, скобок, плюса, минуса и равно. |
| `[Compose]→[_]→[1]`     | `₁`  | `U+2081 SUBSCRIPT ONE`   | Нижний индекс — аналогично предыдущему. |
| `[Compose]→[(]→[1]→[)]` | `①`  | `U+2460 CIRCLED DIGIT ONE` | Цифра в кружочке — для всех цифр работает. |
| `[Compose]→["]→[a]`     | `ä`  | `U+00E4 LATIN SMALL LETTER A WITH DIAERESIS` | Для всех гласных латиницы. |
| `[Compose]→[']→[a]`     | `á`  | `U+00E1 LATIN SMALL LETTER A WITH ACUTE`     | Аналогично предыдущему. |
| `[Compose]→[s]→[s]`     | `ß`  | `U+00DF LATIN SMALL LETTER SHARP S`          | Заглавный эсцет тоже есть — из заглавных S соответственно. |
| `[Compose]→[#]→[b]`     | `♭`  | `U+266D MUSIC FLAT SIGN` | |
| `[Compose]→[#]→[f]`     | `♮`  | `U+266E MUSIC NATURAL SIGN` | |
| `[Compose]→[#]→[#]`     | `♯`  | `U+266F MUSIC SHARP SIGN` | |
| `[Compose]→[P]→[P]`     | `¶`  | `U+00B6 PILCROW SIGN` | Он же «paragraph sign». |
| `[Compose]→[a]→[e]`     | `æ`  | `U+00E6 LATIN SMALL LETTER AE` | Аналогично для заглавных. Так же работает для некоторых рас­прост­ра­нен­ных лигатур, например `ﬁ`, но не для всех. |
| `[Compose]→[:]→[)]`     | `☺`  | `U+263A WHITE SMILING FACE`  | |
| `[Compose]→[:]→[(]`     | `☹`  | `U+2639 WHITE FROWNING FACE` | |
| `[Compose]→[<]→[3]`     | `♥`  | `U+2665 BLACK HEART SUIT` | |
| `[Compose]→[N]→[o]`     | `№`  | `U+2116 NUMERO SIGN` | Если вдруг нет русской раскладки, а знак номера очень хочется... |
| `[Compose]→[o]→[x]`     | `¤`  | `U+00A4 CURRENCY SIGN` | |
| `[Compose]→[s]→[m]`     | `℠`  | `U+2120 SERVICE MARK` | |
| `[Compose]→[<]→[=]`<br>`[Compose]→[>]→[=]` | `≤`<br>`≥`  | `U+2264 LESS-THAN OR EQUAL TO`<br>`U+2265 GREATER-THAN OR EQUAL TO` | Вид нижней черты — горизонтальная или наклонная — зависит от шрифта. |

## Кроличья нора

{:.note.italic}
Этот раздел новый. В 2011 году я так глубоко не закапывался. Тем не менее, конечно, хотелось бы уметь добавлять
произвольные символы для клавиатурного ввода. Это ж Linux, здесь кастомизируется, если не все, то очень многое...
Попробуем.

### ~/.XCompose

Самое простое — это добавить свои сочетания для Compose Key. Для начала идем в файл, расположенный (скорее всего) по пути
`/usr/share/X11/locale/en_US.UTF-8/Compose` и смотрим, чего уже есть, ну и формат описания. Не отвлекаясь на разнообразные
`<dead_tilde>` можно увидеть множество строк, начинающихся с `<Multi_key>` — последовательность имен символов в уголках,
двоеточие, нужный символ в кавычках, его название или номер в юникоде и комментарий. Название или юникод необязательны,
как и комментарий.

А затем создаем в своем домашнем каталоге файл `.XCompose` следующего, например, содержания:

{% highlight xcompose %}
include "/usr/share/X11/locale/en_US.UTF-8/Compose"

<Multi_key> <h> <o> <m> <e> : "🏠" U1F3E0 # HOUSE BUILDING
{% endhighlight %}

Выходим и заходим (нужно переинициализировать сеанс иксов), и вуаля — последовательность `[Compose]→​[h]→​[o]→​[m]→[e]`
выдает символ домика `🏠`[^ff-symbols]. Главное тут следить, чтобы одни последовательности не перекрывали другие —
иначе более короткая не позволит использовать более длинную.

Ввод через Compose Key легко настраивается, но, на мой взгляд, для условно обычных, идущих в потоке, символов не очень
удобен. То есть (лично у меня, по крайней мере) такой способ ввода из потока выбивается. Поэтому символы «дополнительной
пунктуации» или что-то из базовой математики стоит вывести на третий/четвертый уровень, который (опять же лично у меня)
нажимается автоматически и из потока текста не выделяется. Что же до Compose, то тут можно оставить символы-пиктограммы
(как собственно и сделано в примере), эмодзи, или что-то уж совсем редко используемое.

Еще один момент, касающийся потока — это раскладки. Compose работает на уровне символов, а не нажатий клавиш, поэтому
чтобы ввести заданную нами последовательность, придется переключаться из русской (например) раскладки в английскую.
Это, впрочем, можно поправить, задав аналогичную последовательность с соответствующими русскими буквами, правда, выглядеть
такая строка будет страшновато и немнемонично сама по себе:

{% highlight xcompose %}
<Multi_key> <Cyrillic_er> <Cyrillic_shcha> <Cyrillic_softsign> <Cyrillic_u> : "🏠" U1F3E0 # HOUSE BUILDING
{% endhighlight %}

{:.note.italic}
В обсуждениях в интернете видел, что файл `~/.XCompose` обрабатывается не у всех. Я честно не знаю, в каких случаях
бывают проблемы, и что с этим делать, поскольку сам не сталкивался — у меня работает прекрасно.

### Кастомизируем раскладку

Можно было назвать этот подраздел настройкой третьего уровня, но на самом деле изменения в нем и изменения в основной
раскладке клавиатуры ничем не отличаются. Хотя я основную часть менять и не буду (чтобы не вырабатывать вредных привычек,
мешающих затем работе с произвольно взятым посторонним компьютером — частая проблема у любителей кастомных раскладок).

Второй момент: все изменения будем делать на уровне пользователя (так же, как и выше `~/.XCompose`). Это позволит, в случае
неудачного эксперимента, не остаться хотя бы без экрана логина... Да и вообще.

Итак. За раскладки, дополнительные символы и вообще за ввод с клавиатуры в рамках **[X.org][xorg]** отвечает проект
**[XKB][xkb]**, по ссылке можно почитать документацию, которая лично мне помогла примерно никак... К счастью, за прошедшие
10 лет материалов в сети на эту тему существенно прибавилось, и кое-что найти можно. Больше всего мне помогли:

* Пост на Хабре **[«XKB: перенастроим клавиши под себя любимого»][habr]** автора **[philpirj][hauthor]** и [комментарий][hcomment]
  к нему от **[kodx][hcommenter]**.

* Блог (англоязычный) **[Who-T][who-t]**, в первую очередь серия постов **«User-specific XKB configuration»**: [первая часть][wt-1],
  [вторая][wt-2], [третья][wt-3], [итог][wt-sum].

Чтобы добавить символы на третий/четвертый уровень, можно:

1. Создать полностью собственную раскладку, унаследовав от существующей.

2. Создать расширение раскладки, которое будет независимо подключаться к основной, так же, как штатные «До&shy;пол&shy;ни&shy;тель&shy;ные
   типографские символы».

Второй вариант, конечно, предпочтительней. Сразу скажу, что совсем *так же* не получилось — мой блок дополнительных символов не виден
в настройках DE и, что более печально, не получилось оформить его как опцию... Кроме того, включение раскладки делается через явный
вызов **[setxkbmap][setxkbmap]** и **[xkbcomp][xkbcomp]** скриптом-однострочником (который, впрочем, прекрасно помещается в автозагрузку DE).
Почему не все получилось? Ну, возможно, я что-то упускаю, а возможно, все дело в том, что поддержка настройки XKB в X.org неполная,
и для того, чтобы все сделать красиво и по мануалу, нужно переходить на Wayland (который у меня пока что-то не приживается) — см. пост
того же Who-T **[«No user-specific XKB configuration in X»][no-x]**.

Тем не менее, файл с нашими добавочными символами имеет смысл расположить в соответствии с инструкциями — в каталоге
`$XDG_CONFIG_HOME/xkb/symbols/`, вдруг вскорости проблема исправится... (Если переменная `$XDG_CONFIG_HOME` не задана, следует считать ее
равной `$HOME/.config`) Имя файла может быть любое, хотя лучше не использовать уже имеющиеся в системном `/usr/share/X11/xkb/symbols/`,
чтоб не перекрыть чего нужного. Для данного примера я решил не умничать и назвать его `custom`. Содержимое файла у меня такое:

{% highlight xkb %}
default partial alphanumeric_keys
xkb_symbols "typo" {
    include "typo(base)"
    include "nbsp(level3n)"

    key <AB08> { [ NoSymbol, NoSymbol, NoSymbol,    U2039 ] };  // "‹"
    key <AB09> { [ NoSymbol, NoSymbol, NoSymbol,    U203A ] };  // "›"
    key <BKSL> { [ NoSymbol, NoSymbol,      bar, NoSymbol ] };  // "|"
};
{% endhighlight %}

Случай простой — один блок определений символов. `default` означает, что он должен использоваться, если указан только файл,
т.е. `+custom(typo)` и `+custom` — одно и то же. `partial` — что это частичное определение, добавляемое к основе, а не самостоятельная
раскладка. `alphanumeric_keys` показывает, какую область клавиш мы определяем (я, честно говоря, не уверен, что это влияет на результат).
Ну, а `xkb_symbols "typo"` собственно говорит нам, что это за блок.

{:#fix}
Далее мы включаем два стандартных набора — типографские символы и неразрывный пробел *с тонким неразрывным пробелом на четвертом уровне*.
[Выше я писал][bug], что обнаружил баг на своей системе, а сейчас его обхожу. Дело в том, что сам «типографский» набор вводит неразрывный пробел
как на третьем уровне, так и на четвертом, а опция `nbsp:level3n` по идее должна его перекрывать. Но порядок подключения этих модулей
не определяется их порядком в списке опций (а чем определяется, неизвестно), и у меня `typo` перекрывает `nbsp`, а не наоборот. Импортируя
их в своем файле, я убиваю двух зайцев: мне не нужно будет указывать их отдельно (или прописывать их содержимое себе), и порядок импорта
определен жестко порядком строк в файле.

Далее строки определения символов. Начинаются они с ключевого слова `key` и кода клавиши, а затем идет список символов.

Коды клавиш определяются файлами в каталоге `/usr/share/X11/xkb/keycodes/` и зависят от системы. В моем случае, и в большинстве современных
Linux-систем, надо смотреть файл `evdev`. Вкратце, основные алфавитно цифровые клавиши кодируются как `A` (Alphanumeric), ряд буквой от `A` —
пробел, до `E` — цифры (но при этом ряд пробела кодируется весь отдельными именами, и сам пробел — это `<SPCE>`), и номер клавиши в ряду
двумя цифрами (при этом для нумерации игнорируются модификаторы и клавиша с перед цифрами, где русская «Ё» — эта клавиша имеет отдельный код —
`<TLDE>`); гуляющая по рядам в разных клавиатурах клавиша с обратным слэшем кодируется как `<BKSL>`. Таким образом у меня прописаны определения
клавиш `<` (`Б`), `>` (`Ю`) и уже упомянутого обратного слэша.

В списке очевидным образом идут символы по уровням — от первого (клавиша без модификаторов) и далее — вообще уровней может быть много,
но я использую только до четвертого, чего и всем желаю. Напомню, что второй уровень — это клавиша с `[Shift]`, модификатор для третьего
задается опциями XKB, а четвертый — это `[L3]+[Shift]`.

Коды символов могут использоваться как зашитые в недрах системы (их список можно увидеть в файле `/usr/include/X11/keysymdef.h`), так
и обыкновенный юникод. Но есть и два специальных значения: `NoSymbol` означает, что в данной позиции мы символ не перекрываем, т.е.
должен использоваться определенный где-то ранее; а `VoidSymbol` означает отсутствие символа — при нажатии ничего не вводится. Как можно
видеть, я использую `NoSymbol` в большинстве позиций, чтобы там остались старые значения. В первых двух случаях на третьем уровне находятся
кавычки-елочки, они же двойные угловые кавычки, и на четвертый уровень я добавляю их одиночные вариации. В последней строке на третий
уровень добавляется вертикальная черта, которая вообще-то на этой клавише уже есть на втором... но только в английской раскладке. А теперь,
на третьем она будет и в русской раскладке тоже[^double-symbols].

Теперь наше определение символов нужно подключить. Вот такой скрипт у меня вызывается из автозапуска KDE:

{% highlight sh %}
#!/bin/sh

setxkbmap -layout "us+custom,ru:2+custom" \
  -option "" -option "grp:alt_shift_toggle,lv3:win_switch,lv3:ralt_switch,compose:caps" \
  -print | xkbcomp -I$HOME/.config/xkb - "${DISPLAY%%.*}"
{% endhighlight %}

Увы, мне не удалось заставить `setxkbmap` обрабатывать созданные мной правила (их я приводить здесь не буду, раз они все равно не рабочие),
а без них эта программа отказывается устанавливать раскладку самостоятельно, почему и приходится использовать команду `-print` и передавать
созданный `xkb_keymap` в `xkbcomp`. В принципе, его можно было б и сохранить, выглядит он так:

{% highlight xkb %}
xkb_keymap {
        xkb_keycodes  { include "evdev+aliases(qwerty)" };
        xkb_types     { include "complete"      };
        xkb_compat    { include "complete"      };
        xkb_symbols   { include "pc+us+custom+ru:2+custom:2+inet(evdev)+group(alt_shift_toggle)+level3(ralt_switch)+level3(win_switch)+compose(caps)"   };
        xkb_geometry  { include "pc(pc104)"     };
};
{% endhighlight %}

И вызывать `xkbcomp` сразу с этим сохраненным файлом... Но здесь слишком много служебной информации, которая не задается мной, а берется
из умолчаний и системы, кроме того, раскладки логически не разделены с переключателями... В общем, мой вариант скрипта мне кажется логичнее.

Что касается вызова `xkbcomp`, хочу обратить внимание на параметр `-I$HOME/.config/xkb` — указывается не каталог, где непосредственно
лежит файл с символами, а корень конфигурации XKB, где находится подкаталог `symbols` и уже в нем наш файл. Именно через подкаталог
`xkbcomp` его будет искать.

Данный способ расширения раскладки я проверил, помимо основной системы (KDE5, Gentoo) на виртуалках: Cinnamon (Linux Mint), GNOME (Ubuntu),
Xfce (Xubuntu) и LXQt (Lubuntu). Везде все работает. По идее должно работать в любых системах, где используется XKB (и не используются
различные экзотические способы ввода, вероятно).

Относительно же систем, уже использующих Wayland, рекомендую почитать вышеупомянутую серию постов **«User-specific XKB configuration»**
и сделать дословно, как там описано. Кстати, посты там недавние, актуальные — можно позадавать автору вопросы (если английский позволяет).

## Итог

Ввод с клавиатуры в Linux очень гибко и мощно настраивается. Вводить можно любые символы юникода, ограничение тут скорее в том, чтобы их
увидеть — это уже от шрифта зависит, но современные шрифты поддерживают много чего.

При этом базовая настройка простая и делается буквально в несколько кликов. Расширение же возможностей, хоть и сложнее, но тоже не рокет-сайнс,
и оно того стоит.

Список символов, покдлючаемый стандартной опцией `misc:typo` (или через настройки DE, где они есть), можно посмотреть в файле
`/usr/share/X11/xkb/symbols/typo`, а можно пользоваться картинкой из этого поста — зря я что ли ее делал...
Предустановленные комбинации Compose, как выше уже упоминалось, располагаются в файле `/usr/share/X11/locale/en_US.UTF-8/Compose`.



[^check]: Символы я определял, естественно не на глаз, а вводя в поле KCharSelect, так что в дублировании уверен.

[^feet]: Информация про футы из KCharSelect, вживую я такого обозначения не встречал.

[^ff-symbols]: Пользователи Firefox могут увидеть здесь домик раскрашенный в разные цвета, а не просто символ шрифта.
               Это делает именно браузер для многих «иконочных» символов.

[^double-symbols]: Стандартные «типографские символы» организуют такое же поведение для знаков
                   доллара и амперсэнда, помещая их на третий уровень тех же цифровых клавиш,
                   где они есть в английской и отсутствуют в русской раскладке. И то же самое
                   с квадратными и фигурными скобками.

[bug]: #bug
[fix]: #fix

[layout]: /assets/img/2021-03/typo/keyboard-layout.png "Раскладка клавиатуры с третьим и четвертым уровнями"
[zip]: /assets/img/2021-03/typo/keyboard-layout.svg.zip "Архив с SVG-файлом раскладки"
[kde]: /assets/img/2021-03/typo/kde.png "Модуль настройки клавиатуры в KDE"
[ubuntu]: /assets/img/2021-03/typo/ubuntu.png "Настройка клавиатуры в Ubuntu"
[cinnamon]: /assets/img/2021-03/typo/cinnamon.png "Настройка клавиатуры в среде Cinnamon (Linux Mint"
[xfce]: /assets/img/2021-03/typo/xfce.png "Настройки клавиатуры в среде Xfce"

[xorg]: https://www.x.org/
[xkb]: https://www.x.org/wiki/XKB/

[habr]: https://habr.com/ru/post/222285/
[hauthor]: https://habr.com/ru/users/philpirj/
[hcomment]: https://habr.com/ru/post/222285/#comment_7586289
[hcommenter]: https://habr.com/ru/users/kodx/

[who-t]: https://who-t.blogspot.com/
[wt-1]: https://who-t.blogspot.com/2020/02/user-specific-xkb-configuration-part-1.html
[wt-2]: https://who-t.blogspot.com/2020/07/user-specific-xkb-configuration-part-2.html
[wt-3]: https://who-t.blogspot.com/2020/08/user-specific-xkb-configuration-part-3.html
[wt-sum]: https://who-t.blogspot.com/2020/09/user-specific-xkb-configuration-putting.html
[no-x]: https://who-t.blogspot.com/2020/09/no-user-specific-xkb-configuration-in-x.html

[setxkbmap]: https://gitlab.freedesktop.org/xorg/app/setxkbmap
[xkbcomp]: https://gitlab.freedesktop.org/xorg/app/xkbcomp
