---
title: Модуль actions on selection (действия над выбранными)
date: 2025-10-26
source: https://docs.darktable.org/usermanual/development/en/module-reference/utility-modules/lighttable/selected-image/
---

{:.origlink}
+ [docs.darktable.org/user­manual/de­ve­lop­ment/en/mo­du­le-re­fe­ren­ce/uti­li­ty-mo­du­les/light­tab­le/se­lec­ted-image/](https://docs.darktable.org/usermanual/development/en/module-reference/utility-modules/lighttable/selected-image/) (v3.6)

<section class="module">

Модуль позволяет выполнять действия над изображениями, выбранными в пред­став­ле­нии «Световой стол» *(lighttable)*.

## Элементы управления модулем

Элементы управления модуля разделены на две вкладки: для работы с файлами изображений и связанными метаданными.

<div class="unbreakable">

### Вкладка «images»

![actions on selection / images](_src/2025/10/dpg0/img/030_actions_on_selection.png){: width="245" href="none" }

remove

: Удаляет выбранные изо­бра­же­ния из библиотеки darktable, не удаляя их с файловой системы. Удаленные изображения больше
  не отображаются и не редактируются в darktable, но са­ми файлы изображений и связанные XMP-фай­лы остаются на диске.
  Поскольку darktable обновляет XMP-фай­лы с по­с­лед­ней историей обработки, вы можете полностью восстановить работу,
  повторно импортировав изображения.

</div>
<div class="unbreakable">

delete / delete (trash)

: Удаляет выбранные изображения из библиотеки darktable и связанные XMP-файлы с файловой системы. Если в библиотеке darktable
  нет дубликатов удаленного изображения, сам файл изображения также удаляется.
  Настройка в [preferences > security](https://docs.darktable.org/usermanual/development/en/preferences-settings/security/) определяет,
  удаляются ли файлы безвозвратно или перемещаются в корзину системы. Другая настройка в той же вкладке позволяет включить или
  отключить запрос подтверждения перед удалением.

</div>
<div class="unbreakable">

move

: Физически перемещает выбранные изображения (файлы изображений и связанные XMP-файлы) в другую папку на файловой системе.
  Если в целевой папке уже существует изображение с таким же именем файла, исходное изображение не будет перемещено.

</div>
<div class="unbreakable">

copy

: Физически копирует выбранные изображения (файлы изображений и связанные XMP-файлы) в другую папку на файловой системе.
  Если в целевой папке уже существует изображение с таким же именем файла, оно не будет перезаписано — вместо этого создается
  новый дубликат с той же историей обработки, что и у исходного изображения.

</div>
<div class="unbreakable">

create HDR

: Создает изображение с высоким динамическим диапазоном (HDR) из выбранных изображений и добавляет результат в библиотеку
  как новое изображение в формате DNG. Изображения должны быть правильно выровнены, что предполагает съемку с надежного штатива.
  Также можно создавать HDR в программах вроде Luminance HDR и затем импортировать их в darktable для дальнейшей обработки.
  Обратите внимание, что darktable создает HDR только из RAW-файлов.

</div>
<div class="unbreakable">

duplicate

: Создает дубликаты выбранных изображений внутри darktable. Дубликаты используют тот же файл изображения, но каждый имеет
  собственный XMP-файл и отдельную запись в базе данных библиотеки darktable. Это позволяет тестировать разные варианты обработки
  одного изображения.

</div>
<div class="unbreakable">

Повороты (![](_src/2025/10/dpg0/img/032_rotate_left.png){: width="19" href="none" } / ![](_src/2025/10/dpg0/img/033_rotate_right.png){: width="19" href="none" }) и reset rotation

: Выполняет поворот выбранных изображений по часовой стрелке или против часовой стрелки. Третья кнопка сбрасывает поворот до значения,
  указанного в EXIF-данных изображения. Эта функция напрямую связана с модулем обработки
  [_orientation_](https://docs.darktable.org/usermanual/development/en/module-reference/processing-modules/orientation/) —
  изменения автоматически преобразуются в элемент истории обработки для этого модуля.

</div>
<div class="unbreakable">

copy locally

: Создает локальные копии выбранных изображений на локальном диске. Эти копии используются, когда исходные изображения недоступны
  (см. [local copies](https://docs.darktable.org/usermanual/development/en/overview/sidecar-files/local-copies/)).

</div>
<div class="unbreakable">

resync local copy

: Синхронизирует XMP-файлы локальных копий выбранных изображений с копиями во внешнем хранилище и удаляет локальные копии.
  Если локальная копия была изменена, а внешнее хранилище недоступно, локальная копия не удаляется
  (см. [local copies](https://docs.darktable.org/usermanual/development/en/overview/sidecar-files/local-copies/)).

</div>
<div class="unbreakable">

group

: Создает новую группу из выбранных изображений
  (см. [image gro­u­ping](https://docs.darktable.org/usermanual/development/en/lighttable/digital-asset-management/grouping/)).

</div>
<div class="unbreakable">

ungroup

: Удаляет выбранные изображения из их группы
  (см. [image grouping](https://docs.darktable.org/usermanual/development/en/lighttable/digital-asset-management/grouping/)).

</div>
<div class="unbreakable">

### Вкладка «metadata»

![actions on selection / metadata](_src/2025/10/dpg0/img/031_actions_on_selection_metadata.png){: width="245" href="none" }

Чекбоксы типов метаданных

: Позволяет выбрать типы метаданных (ratings, tags, metadata, colors, geo­tags), над которыми вы хотите работать.

</div>
<div class="unbreakable">

copy

: Копирует выбранные ти­пы метаданных с выбранного изображения в бу­фер обмена. Если выбрано более одного изображения или ни одного,
  кнопка недоступна.

</div>
<div class="unbreakable">

paste

: Вставляет метаданные из буфера обмена на выбранные изображения.

</div>
<div class="unbreakable">

clear

: Очищает выбранные типы метаданных с выбранных изображений.

</div>
<div class="unbreakable">

mode

: При вставке метаданных определяет, будут ли метаданные из буфера обмена объединены с существующими (_merge_)
  или полностью заменят их (_overwrite_).

</div>
<div class="unbreakable">

refresh EXIF

: Обновляет EXIF-данные из исходного файла. Внимание: это может перезаписать некоторые теги и метаданные, измененные в darktable
  (например, оценки в звездах).

</div>
<div class="unbreakable">

monochrome

: Помечает изображение как монохромное, что активирует специфическую обработку для монохромных изображений в модулях обработки.
  Подробности см. в разделе справки
  [developing monochrome images](https://docs.darktable.org/usermanual/development/en/guides-tutorials/monochrome/).

</div>
<div class="unbreakable">

color

: Снимает пометку монохромного изображения, возвращая его к стандартной обработке, используемой для цветных фотографий.

</div>

</section>
