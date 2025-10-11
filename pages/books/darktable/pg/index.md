---
title: Практическое руководство по darktable
short: Практическое руководство
icon: book-open
last_modified_at: 2025-10-10
---

<hr style="border: 2px; margin: 20px auto; width: 40%;">

{% include book/gpl.html %}

-----

Поскольку функционал **darktable** весьма обширен и, более того,
во многих аспектах требует не только примеров, но и существенных теоретических пояснений, изложение разделено на несколько глав,
выстроенных по принципу «от простого к сложному», и некоторые темы рассматриваются в нескольких главах на разном уровне.

## Оглавление (план)

<section class="booktoc">

### [Введение]({%- link pages/books/darktable/pg/0_intro.md -%})

+ **[Обзор]({%- link pages/books/darktable/pg/0_intro.md -%} #overview)**

  + [Установка]({%- link pages/books/darktable/pg/0_intro.md -%} #install)

  + [Интерфейс]({%- link pages/books/darktable/pg/0_intro.md -%} #interface)

+ **[Начало работы]({%- link pages/books/darktable/pg/0_intro.md -%} #start)**

  + [Импорт]({%- link pages/books/darktable/pg/0_intro.md -%} #start-import)
    + [Связанные XMP-файлы]({%- link pages/books/darktable/pg/0_intro.md -%} #xmp-files)

  + [Световой стол]({%- link pages/books/darktable/pg/0_intro.md -%} #lighttable)
    + [Рабочая область]({%- link pages/books/darktable/pg/0_intro.md -%} #work-area)
    + [Верхняя панель]({%- link pages/books/darktable/pg/0_intro.md -%} #top-panel)
    + [Нижняя панель]({%- link pages/books/darktable/pg/0_intro.md -%} #bottom-panel)
    + [Боковые панели]({%- link pages/books/darktable/pg/0_intro.md -%} #side-panels)
    + [Таймлайн и лента кадров]({%- link pages/books/darktable/pg/0_intro.md -%} #timeline-filmstrip)

  + [Экспорт]({%- link pages/books/darktable/pg/0_intro.md -%} #start-export)

+ **[Итог]({%- link pages/books/darktable/pg/0_intro.md -%} #done)**

+ **[Справочная информация]({%- link pages/books/darktable/pg/0_intro.md -%} #refs)**

  + [Модуль actions on selection (действия над выбранными)]({%- link pages/books/darktable/pg/0_intro.md -%} #mod-actions-on-selection)

  + [Модуль collections (коллекции)]({%- link pages/books/darktable/pg/0_intro.md -%} #mod-collections)

  + [Модуль export (экспорт)]({%- link pages/books/darktable/pg/0_intro.md -%} #mod-export)

  + [Модуль filmstrip (лента миниатюр)]({%- link pages/books/darktable/pg/0_intro.md -%} #mod-filmstrip)

  + [Модуль image information (информация об изображении)]({%- link pages/books/darktable/pg/0_intro.md -%} #mod-image-information)

  + [Модуль import (импорт)]({%- link pages/books/darktable/pg/0_intro.md -%} #mod-import)

  + [Модуль selection (выбор)]({%- link pages/books/darktable/pg/0_intro.md -%} #mod-selection)

  + [Модуль timeline (таймлайн)]({%- link pages/books/darktable/pg/0_intro.md -%} #mod-timeline)

</section>

<section class="booktoc">

### [Глава 1: Базовая обработка]({%- link pages/books/darktable/pg/1_base_processing.md -%})

</section>

Рассмотрим основные действия, которые всегда (или почти всегда) приходится производить над снимками.

+ Коррекции: устранение оптических искажений, шумоподавление, баланс белого, восстановление пересветов.

+ Уровни, кривые, локальный контраст. Вытягивание теней и светов.

+ Кадрирование, поворот и перспектива.

Также обсудим варианты демозаики.

<section class="booktoc">

### Глава 2: Организация изображений

Здесь мы подробно рассмотрим работу с коллекциями, тегами и метаданными.

Также рассмотрим представление карты и вообще работу с геопривязками.

### Глава 3: Базовая цветокоррекция

Рассмотрим цветовой баланс, раздельные кривые и уровни по каналам, цветовые профили.

### Глава 4: Рабочий процесс

Здесь мы углубимся в детали работы именно **darktable**: рассмотрим варианты workflow, порядка модулей и т.д.

Здесь же рассмотрим работу с масками и множественным использованием модулей — как разные части изображения можно обрабатывать по разному.

### Глава 5: Продвинутая цветокоррекция

Тут поговорим о цветовых моделях и пространствах, в которых работает **darktable**, и рассмотрим более сложные инструменты работы с цветом.

### Глава 6: Ретушь и улучшения

Ряд модулей предназначен для улучшения или скрытия недостатков и обычно применяется в обработке портретов.
Здесь мы поговорим именно об этом. Естественно, на живом примере.

### Глава 7 и далее

</section>

Здесь пока нет окончательной разбивки по главам. Можно сказать, какие темы будут рассмотрены:

+ Стили и пресеты (если не будут подробно описаны ранее);

+ Скрипты Lua — автоматизация и добавление своей логики, а также вариантов экспорта;

+ Управление съемкой — представление «Камера» и работа непосредственно с подключенной камерой;

+ Вопросы оптимизации: выбор алгоритмов для тяжелых задач, настройки, связанные с видеокартой, и т.д.;

+ Художественные и специфические задачи — то, что обычно называется «эффекты».

## Общие моменты

Структура изложения внутри глав будет аналогична структуре данного Введения — сначала рассматриваем процесс на конкретном примере,
затем справочная информация (максимально точный перевод официальной справки, там, где она недостаточна или устарела, будут сноски,
а не авторское вмешательство в текст). В конце каждой главы краткий итог: что пройдено.

-----

{% include book/gpl.html %}

-----
