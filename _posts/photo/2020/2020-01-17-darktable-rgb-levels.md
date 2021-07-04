---
title: Новый модуль Darktable — «Уровни RGB»
category: [ photo, processing, tech, soft, graphics ]
tags:
  - Darktable
  - цвет
  - RAW
  - Linux

description: Новый модуль в Darktable 3.0 — пример использования
image: /assets/img/2020-01/rgb/RGB.png
---
Продолжаю изучать новые возможности Darktable 3.0. Пробежался по некоторым новым модулям,
пока не впечатлен,  но кое-что интересное нашлось. Модуль называется «Уровни RGB[^foot-rgb-levels]»
и делает, в общем, то же самое, что и старый модуль «Уровни» (правда, без полностью автоматического
режима), но с возможностью работы по отдельным каналам красного, зеленого и синего. Что это
дает на практике, сейчас и рассмотрим.

{% include nova/image.html place="center" width=800 src="/assets/img/2020-01/rgb/RGB.png" title="Панели модуля «Уровни RGB»" %}

<!--more-->

Итак, есть вот такая фотография, снятая при плохих условиях освещения — зима, тень, веточки,
сквозь которые просвечивает черте-что... Вот так она выглядит при проявке по умолчанию
[с моими обычными предустановками][quickstart]:

{% include nova/image.html place="center" width=800 src="/assets/img/2020-01/rgb/default.jpg" title="Фотография с обычными предустановками" %}

Что характерно, [настройка сохранения цветов в модуле базовой кривой][basecurve] не влияет на картинку
*совсем*, а полное отключение этого модуля не влияет *почти*. В любом случае мы получаем
отсутствие контраста в тенях (т.е. в данном случае именно в значимой части снимка)
и перекос в сторону синевы.

Что ж, попробуем исправить проблему старыми средствами. Для начала поправим контраст
посредством «Тональной кривой[^foot-tonecurve][^foot-tonecurve-ru]»,
выбрав предустановку «Сжатие контраста»:

{% include nova/image.html place="center" width=800 src="/assets/img/2020-01/rgb/contrast.jpg" title="Фотография со сжатием контраста" %}

Затем в настройках баланса белого[^foot-bb][^foot-bb-ru]
вместо профиля камеры выберем вариант «Пипетка» и область всей картинки (или большей части):

{% include nova/image.html place="center" width=800 src="/assets/img/2020-01/rgb/bb.jpg" title="Фотография с исправленным балансом белого" %}

В целом, уже неплохо.

А теперь обратимся к новому модулю «Уровни RGB», *предварительно отключив старые «Уровни»
и «Тональную кривую», это важно*. Выберем сверху режим «RGB (независимые)» и в каждом канале
потыкаем кнопку «Авто» (просто автоматического режима, как я уже сказал, тут не предусмотрено):

{% include nova/image.html place="center" width=800 src="/assets/img/2020-01/rgb/levels.jpg" title="Фотография после применения модуля «Уровни RGB»" %}

Удивительным образом мы получили более чистую и отчетливую картинку, чем в предыдущем
случае (хотя и предыдущую, скорее всего, можно было бы довести до такого же,
поигравшись вручную с уровнями и кривыми, но вручную же).

Итого: инструмент, конечно, для очень специфических случаев, но вполне годный.

[quickstart]: {% link _posts/photo/2019/2019-09-21-darktable-quickstart.md %} "Darktable — (не очень) быстрый старт"
[basecurve]: {% link _posts/photo/2020/2020-01-14-darktable-new-basecurve.md %} "Новая базовая кривая в Darktable"

[^foot-rgb-levels]: Документация по модулю «Уровни RGB» (en, v3.4): <https://www.darktable.org/usermanual/en/module-reference/processing-modules/rgb-levels/>
[^foot-tonecurve]: Тоновая кривая (en, v3.4): <https://www.darktable.org/usermanual/en/module-reference/processing-modules/tone-curve/>
[^foot-tonecurve-ru]: Тоновая кривая (ru, v2.4): <https://photoredroom.blogspot.com/2018/07/dttonegroup3.html>
[^foot-bb]: Баланс белого (en, v3.4): <https://www.darktable.org/usermanual/en/module-reference/processing-modules/white-balance/>
[^foot-bb-ru]: Баланс белого (ru, v2.4): <https://photoredroom.blogspot.com/2018/06/dtbasicgroup10.html>
