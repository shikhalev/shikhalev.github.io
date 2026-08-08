---
title: Практическое руководство по darktable
short: Практическое руководство
icon: book-open
last_modified_at: 2025-10-26
---

<hr style="border: 2px; margin: 20px auto; width: 40%;">

{% include book/gpl.html %}

-----

Поскольку функционал **darktable** весьма обширен и, более того,
во многих аспектах требует не только примеров, но и существенных теоретических пояснений, изложение разделено на несколько глав,
выстроенных по принципу «от простого к сложному», и некоторые темы рассматриваются в нескольких главах на разном уровне.

## Оглавление (план)

<section class="booktoc">

### [Введение]({%- link _matters/lib/darktable/pg/0_intro.md -%})

+ **[Обзор]({%- link _matters/lib/darktable/pg/0_intro.md -%} #overview)**

  + [Установка]({%- link _matters/lib/darktable/pg/0_intro.md -%} #install)

  + [Интерфейс]({%- link _matters/lib/darktable/pg/0_intro.md -%} #interface)

+ **[Начало работы]({%- link _matters/lib/darktable/pg/0_intro.md -%} #start)**

  + [Импорт]({%- link _matters/lib/darktable/pg/0_intro.md -%} #start-import)
    + [Связанные XMP-файлы]({%- link _matters/lib/darktable/pg/0_intro.md -%} #xmp-files)

  + [Световой стол]({%- link _matters/lib/darktable/pg/0_intro.md -%} #lighttable)
    + [Рабочая область]({%- link _matters/lib/darktable/pg/0_intro.md -%} #work-area)
    + [Верхняя панель]({%- link _matters/lib/darktable/pg/0_intro.md -%} #top-panel)
    + [Нижняя панель]({%- link _matters/lib/darktable/pg/0_intro.md -%} #bottom-panel)
    + [Боковые панели]({%- link _matters/lib/darktable/pg/0_intro.md -%} #side-panels)
    + [Таймлайн и лента кадров]({%- link _matters/lib/darktable/pg/0_intro.md -%} #timeline-filmstrip)

  + [Экспорт]({%- link _matters/lib/darktable/pg/0_intro.md -%} #start-export)

+ **[Итог]({%- link _matters/lib/darktable/pg/0_intro.md -%} #done)**

+ **[Справочная информация]({%- link _matters/lib/darktable/pg/0_intro.md -%} #refs)**

  + [Модуль actions on selection (действия над выбранными)]({%- link _matters/lib/darktable/pg/0_intro.md -%} #mod-actions-on-selection)

  + [Модуль collections (коллекции)]({%- link _matters/lib/darktable/pg/0_intro.md -%} #mod-collections)

  + [Модуль export (экспорт)]({%- link _matters/lib/darktable/pg/0_intro.md -%} #mod-export)

  + [Модуль filmstrip (лента миниатюр)]({%- link _matters/lib/darktable/pg/0_intro.md -%} #mod-filmstrip)

  + [Модуль image information (информация об изображении)]({%- link _matters/lib/darktable/pg/0_intro.md -%} #mod-image-information)

  + [Модуль import (импорт)]({%- link _matters/lib/darktable/pg/0_intro.md -%} #mod-import)

  + [Модуль selection (выбор)]({%- link _matters/lib/darktable/pg/0_intro.md -%} #mod-selection)

  + [Модуль timeline (таймлайн)]({%- link _matters/lib/darktable/pg/0_intro.md -%} #mod-timeline)

</section>

<section class="booktoc">

### [Глава 1: Базовая обработка]({%- link _matters/lib/darktable/pg/1_base_processing.md -%})

+ **[О чем эта глава?]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #about)**

  + [Задачи]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #tasks)

  + [Процесс]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #process)

+ **[Интерфейс тёмной комнаты]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #darkroom)**

  + [Нижняя панель]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #bottom)

  + [Левая панель]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #left)
    + [navigation]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #navigation)
    + [Прочие модули]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #left-other)

  + [Правая панель]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #right)
    + [scopes]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #scopes)
    + [Управление модулями]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #module-control)

  + [Пресеты и стили]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #presets)

+ **[Порядок работы]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #working)**

  + [Открываем файл]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #opening)

  + [Еще немного автоматики]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #automatics)

  + [Геометрия]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #geometry)

  + [Вытягиваем тени]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #shadows)
    + [Множественная экспозиция в модуле базовой кривой]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #multiexpo)
    + [Базовая кривая + модуль экспозиции]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #expo)
    + [RGB-уровни + RGB-кривая]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #rgbs)
    + [Другие варианты и выбор между ними]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #shadows-other)

  + [Финальный штрих]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #fine)

+ **[Итог]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #done)**

+ **[Справочная информация]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #refs)**

  + [Модуль base curve (базовая кривая)]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #mod-base-curve)

  + [Модуль crop (кадрирование)]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #mod-crop)

  + [Модуль demosaic (демозаика/дебайеризация)]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #mod-demosaic)

  + [Модуль exposure (экспозиция)]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #mod-exposure)

  + [Модуль highlight reconstruction (восстановление пересветов)]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #mod-highlight-reconstruction)

  + [Модуль history (история изменений)]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #mod-history)

  + [Модуль input color profile (входной цветовой профиль)]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #mod-input-color-profile)

  + [Модуль lens correction (исправление искажений объектива)]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #mod-lens-correction)

  + [Модуль local contrast (локальный контраст)]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #mod-local-contrast)

  + [Модуль navigation (навигация)]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #mod-navigation)

  + [Модуль orientation (ориентация)]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #mod-orientation)

  + [Модуль output color profile (выходной цветовой профиль)]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #mod-output-color-profile)

  + [Модуль rgb curve (RGB-кривая)]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #mod-rgb-curve)

  + [Модуль rgb levels (RGB-уровни)]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #mod-rgb-levels)

  + [Модуль rotate and perspective (поворот и перспектива)]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #mod-rotate-perspective)

  + [Модуль scopes (приборы)]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #mod-scopes)
    + [histogram (гистограмма)]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #histogram)
    + [waveform (осциллограмма)]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #waveform)
    + [RGB parade (парад каналов RGB)]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #rgb-parade)
    + [vectorscope (вектороскоп)]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #vectorscope)

  + [Модуль tone curve (тоновая кривая)]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #mod-tone-curve)

  + [Модуль white balance (баланс белого)]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #mod-white-balance)

  + [Устройство модулей обработки (I)]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #doc-processing-modules)
    + [Заголовок модуля]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #doc-module-header)
    + [Пресеты]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #doc-presets)
    + [Элементы управления модулями]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #doc-module-controls)
    + [Кривые]({%- link _matters/lib/darktable/pg/1_base_processing.md -%} #doc-curves)

</section>

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
