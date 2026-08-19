---
title: Модуль rgb levels (RGB-уровни)
date: 2025-10-26
source: https://docs.darktable.org/usermanual/development/en/module-reference/processing-modules/rgb-levels/
---

{:.origlink}
+ [docs.darktable.org/usermanual/development/en/module-reference/processing-modules/rgb-levels/](https://docs.darktable.org/usermanual/development/en/module-reference/processing-modules/rgb-levels/) v3.2.1

<section class="module">

![Модуль «rgb levels»](_src/2025/10/dpg1/132_rgb_levels.png){: width="249" crop="249x358+1651+363" href="none" }

Настраивайте чёрные, белые и средние серые точки в цветовом пространстве RGB. Этот модуль похож на модуль
[_levels_](https://docs.darktable.org/usermanual/development/en/module-reference/processing-modules/levels/),
который работает в цветовом пространстве Lab.

Инструмент *rgb levels* отображает гистограмму изображения и показывает три полосы с ручками. Перетаскивайте ручки, чтобы изменить черную,
среднюю серую и белую точки по яркости (в режиме «RGB, связанные каналы») или независимо для каждого из каналов R, G и B
(в ре­жи­ме «RGB, независимые каналы»).

Перемещение полос чёрного и белого цвета к левому и правому краям гистограммы заставит итоговое изображение охватывать
весь доступный тональный диапазон. Это увеличит контраст изображения.

Перемещение средней полосы изменяет средние тона. Переместите её влево, чтобы изображение стало светлее, и вправо — чтобы затемнить.
Это часто называется изменением гаммы изображения.

Доступны три [пипетки]({%- link _matters/tr/darktable/manual/darkroom/processing-modules/module-controls.md -%} #doc-pickers) для выборки черной, белой и серой точек с изображения.

---

**Примечание:** При определённых условиях, особенно при сильно насыщенных источниках синего света, модуль _levels_ может создавать
артефакты в виде чёрных пикселей. Смотрите параметр «gamut clipping» модуля [_input color profile_]({% link _matters/tr/darktable/manual/module-reference/processing-modules/input-color-profile.md %})
для информации о том, как снизить влияние этой проблемы.

---

## Элементы управления модулем

mode

: Режим работы. Значение по умолчанию — «RGB, связанные каналы», предоставляющее единственный инструмент уровней, который обновляет
  все каналы с учётом выбранного метода сохранения цвета (см. параметр «preserve colors» ниже). «RGB, независимые каналы» предоставляет
  отдельное управление уровнями для каждого из каналов R, G и B.

auto

: Автоматически настраивает чёрную и белую точки и ставит серую точку ровно посередине между ними. Используйте [пипетку]({%- link _matters/tr/darktable/manual/darkroom/processing-modules/module-controls.md -%} #doc-pickers)
  для автоматической настройки на основании выбранного региона изображения.

preserve colors

: Выберите метод сохранения цвета при использовании режима «RGB, связанные каналы» (значение по умолчанию — «luminance»).

</section>
