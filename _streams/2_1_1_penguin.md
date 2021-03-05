---
layout: category
category_id: penguin
parent: processing
title: «Пингвин-фотолюбитель»
short: Пингвин-фотолюбитель
description: Цикл постов 2016 года об обработке фотографий под Linux
permalink: /photo/processing/penguin/
inaturalist: true
---
## Содержание

<div class="center-box">
[![][peng]][commons]

{:.caption}
[Картинка взята с WikiMedia Commons][commons]
</div>

Пожалуй, теперь, когда этот цикл постов немного устарел, его можно считать законченным. Он остается вполне полезным,
но с учетом значительного обновления, как использованного софта, так и моих знаний о нем, дорабатывать я его не буду —
надо переписывать целиком.

* **[Предисловие][preamble]**

  О чем пойдет речь, и о чем не пойдет...

* **[1. «Проявка» RAW-файлов][raw]**

  Как использовать **[Darktable][darktable]**, и (очень кратко) какие еще есть варианты...

* **[2. Командная строка и пакетная обработка][commandline]**

  Получение данных EXIF и обработка в командной строке посредством **[ImageMagick][imagemagick]**...

  * **[2а. Краткое замечание к предыдущим сериям][2a]**

    Демонстрация странностей работы **[UFRaw][ufraw]**...

  * **[2б. Краткое примечание к краткому замечанию][2b]**

    Исправление дисторсии: в чем все-таки UFRaw прав, и как это сделать в Darktable...

* **[3. Панорамы][panos]**

  Склейка панорам посредством программы **[Hugin][hugin]**...

* **[4. HDR][hdr]**

  Работа с расширенным динамическим диапазоном с помощью **[Luminance HDR][luminance]**...

* **[5. Стекинг][stacking]**

  Стекинг (посредством **[enblend/enfuse][enblend]**) по экспозиции и по фокусу,
  а также уменьшение шумов без потери детализации...

А как послесловие к этому циклу порекомендую пост **[«Darktable — (не очень) быстрый старт»][quickstart]**.
Он намного свежее и подробнее (но только про Darktable).


[peng]: /assets/img/2016-06/p-00/peng.jpg
[commons]: https://commons.wikimedia.org/wiki/File:Penguin_in_Antarctica_jumping_out_of_the_water.jpg

[preamble]: {% link _posts/photo/2016/2016-06-11-preamble.md %}
[raw]: {% link _posts/photo/2016/2016-06-13-raw.md %}
[commandline]: {% link _posts/photo/2016/2016-06-15-a-commandline.md %}
[2a]: {% link _posts/photo/2016/2016-06-15-b-2a.md %}
[2b]: {% link _posts/photo/2016/2016-06-16-2b.md %}
[panos]: {% link _posts/photo/2016/2016-06-17-hugin.md %}
[hdr]: {% link _posts/photo/2016/2016-06-18-hdr.md %}
[stacking]: {% link _posts/photo/2016/2016-06-23-stacking.md %}
[quickstart]: {% link _posts/photo/2019/2019-09-21-darktable-quickstart.md %}

[darktable]: https://www.darktable.org/
[imagemagick]: https://www.imagemagick.org/
[ufraw]: http://ufraw.sourceforge.net/
[hugin]: http://hugin.sourceforge.net/
[luminance]: http://qtpfsgui.sourceforge.net/
[enblend]: http://enblend.sourceforge.net/
