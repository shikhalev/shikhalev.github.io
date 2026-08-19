---
title: Модуль orientation (ориентация)
date: 2025-10-26
source: https://docs.darktable.org/usermanual/development/en/module-reference/processing-modules/orientation/
---

{:.origlink}
+ [docs.darktable.org/usermanual/development/en/module-reference/processing-modules/orientation/](https://docs.darktable.org/usermanual/development/en/module-reference/processing-modules/orientation/) v3.8

<section class="module">

![Модуль «orientation»](_src/2025/10/dpg1/117_orientation.png){: width="249" crop="249x89+1651+528" href="none" }

Поворачивает изображение на 90 градусов за раз или отражает изображение по горизонтали и/или вертикали.

Модуль включен по умолчанию, и ориентация (поворот) автоматически устанавливается на основе EXIF-дан­ных изображения.

Ориентацию также можно задать с помощью модуля [actions on selection]({%- link _matters/tr/darktable/manual/module-reference/utility-modules/lighttable/actions-on-selection.md -%})
(действия над выбранными) в представлении *[lighttable](https://docs.darktable.org/usermanual/development/en/lighttable/)* (световой стол).

**Примечание:** Область кадрирования модуля [_crop_]({% link _matters/tr/darktable/manual/module-reference/processing-modules/crop.md %}) (кадрирование) сохраняется при изменении ориентации.

<div class="unbreakable">

## Элементы управления модуля

transform

: Двойной клик на метке сбрасывает настройки на трансформации по умол­ча­нию.

</div>

![](_src/2025/10/dpg1/117_orientation.png){: width="20" crop="20x20+1745+564" href="none" } — поворот против часовой стрелки

: Поворачивает изображение на 90 градусов против часовой стрелки.

![](_src/2025/10/dpg1/117_orientation.png){: width="20" crop="20x20+1785+564" href="none" } — поворот по часовой стрелке

: Поворачивает изображение на 90 градусов по часовой стрелке.

![](_src/2025/10/dpg1/117_orientation.png){: width="20" crop="20x20+1824+564" href="none" } — отражение по горизонтали

: Отражает изображение (зеркально) по горизонтали.

![](_src/2025/10/dpg1/117_orientation.png){: width="20" crop="20x20+1863+564" href="none" } — отражение по вертикали

: Отражает изображение (зеркально) по вертикали.

show guides

: Установите флажок, чтобы отображать наложение направляющих, когда модуль активирован. Кликните на значок справа, чтобы настроить
  свойства направляющих. Подробности
  см. в [gui­des & over­lays](https://docs.darktable.org/usermanual/development/en/module-reference/utility-modules/darkroom/guides-overlays/)
  (направляющие и наложения).

</section>
