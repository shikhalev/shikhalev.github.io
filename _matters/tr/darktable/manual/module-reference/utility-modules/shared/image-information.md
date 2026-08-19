---
title: Модуль image information (информация об изображении)
date: 2025-10-26
source: https://docs.darktable.org/usermanual/development/en/module-reference/utility-modules/shared/image-information/
---

{:.origlink}
+ [docs.darktable.org/usermanual/development/en/module-reference/utility-modules/shared/image-information/](https://docs.darktable.org/usermanual/development/en/module-reference/utility-modules/shared/image-information/) (v3.6)

<section class="module">

![Модуль «image information»](_src/2025/10/dpg0/img/041_image_information.png){: width="252" href="none" }

Отображает информацию, встроенную в EXIF-данные изображения, а также ряд дополнительных полей данных, определённых в darktable.

При наведении мыши на миниатюры изображений отображаемые данные автоматически обновляются, показывая информацию об изображении,
над которым в данный момент находится курсор мыши.

Если выбрано несколько изображений и фокус не находится на одном изображении, модуль отображает только информацию,
которая одинакова для всех изображений. Если какие-либо поля различаются между изображениями, вместо этого отображается
текст «_<various values>_».

{:.unbreakable}
Находясь в представлении lighttable (световой стол), вы можете дважды кликнуть на поле _filmroll_ для данного изображения,
чтобы показать все кадры в «катушке» этого изображения.

<div class="unbreakable">

## Настройки

Опция «preferences...» в меню пресетов вызывает диалог со списком всех полей, доступных для отображения.

</div>

Флажок _visible_ позволяет выбрать, какие поля отображать. Вы также можете перетаскивать строки по одной,
чтобы изменить порядок отображения.

{:.unbreakable}
Эти настройки можно сохранить как пресеты модуля. Нажмите кнопку сброса модуля, чтобы сделать всю доступную
информацию видимой и отобразить её в порядке по умолчанию.

</section>
