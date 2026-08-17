---
title: Модуль output color profile (выходной цветовой профиль)
date: 2026-08-16
source: https://docs.darktable.org/usermanual/development/en/module-reference/processing-modules/output-color-profile/
---

{:.origlink}
+ [docs.darktable.org/usermanual/development/en/module-reference/processing-modules/output-color-profile/](https://docs.darktable.org/usermanual/development/en/module-reference/processing-modules/output-color-profile/) v3.6

<section class="module">

![Модуль «output color profile»](_src/2025/10/dpg1/129_output_color_profile.png){: width="249" crop="249x60+1651+330" href="none" }

Управляет выходным профилем для экспорта и методом рендеринга, используемым при преобразовании между цветовыми пространствами.

darktable поставляется с предустановленными профилями _sRGB_, _Adobe RGB_, _XYZ_ и _linear RGB_. Вы можете добавить дополнительные
профили, разместив их в каталогах `$DARKTABLE/share/darktable/color/out` и `$HO­ME/.config/darktable/color/out` (где `$DARKTABLE` —
это каталог установки darktable, а `$HOME` — ваш домашний каталог). Обратите внимание, что эти каталоги `color/out` не создаются
при установке darktable; если вам нужно их использовать, вы должны создать их самостоятельно.

Выходной цветовой профиль также может быть определён в модуле [export]({%- link _matters/tr/darktable/manual/module-reference/utility-modules/shared/export.md -%}).

<div class="unbreakable">

## Элементы управления модуля

output intent

: Метод рендеринга для вывода/экспорта. Выбор метода рендеринга доступен только при использовании
  **[LittleCMS2](https://www.littlecms.com/)**[^littlecms] для применения вы­ход­но­го
  цветового профиля (это можно изменить
  в [pre­fe­ren­ces > pro­ces­sing](https://docs.darktable.org/usermanual/development/en/preferences-settings/processing/)).
  Если используются внутренние процедуры рендеринга darktable, эта опция скрыта. Подробности см. в раз­де­ле
  [ме­тод рен­де­рин­га](https://docs.darktable.org/usermanual/development/en/special-topics/color-management/rendering-intent/).

</div>

output profile

: Профиль, используемый для рендеринга цветов при выводе/экспорте. Данные профиля будут встроены в выходной файл (если это поддерживается
  форматом файла), что позволит другим приложениям правильно интерпретировать его цвета. Поскольку не все приложения учитывают цветовые
  профили, общая рекомендация — использовать *sRGB*, если вы не уверены в своих действиях и у вас нет веских причин поступать иначе.

</section>

[^littlecms]: <https://www.littlecms.com/>
