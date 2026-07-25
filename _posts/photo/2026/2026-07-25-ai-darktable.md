---
title: AI-функции в Darktable 5.6
description: В Darktable завезли нейросетевой шумодав и апскейлер (и не только).
category:
  - photo
  - processing
  - tech
  - soft
  - graphics
tags:
  - Darktable
  - RAW
  - AI
  - нейросети
  - шумоподавление
image: _src/2026/07/ai-darktable/20260724_173940.png
seo_image_crop: 1318x688+17+0
announce: true
---

{% image @_src/2026/07/ai-darktable/20260724_211905.png figure right width=329px title="Модуль neural restore" link=false %}

Недавно вышел **[Darktable 5.6.0][release]{:.img-icon-darktable}**. Там довольно много нового и интересного, но, конечно,
главное, что обращает на себя внимание — это AI-функции. Имеются: шумоподавление в RAW, просто шумоподавление, апскейл (т.е.
увеличение картинки) и маски. Маски я пока не смотрел — я ими как-то вообще не пользуюсь и не очень понимаю, что проверять.
Шумодавами и апскейлом я, правда, тоже почти не пользуюсь, но куда смотреть — представляю.

## Что дают?

Итак. «raw denoise», «denoise» и «upscale». Как можно видеть на скриншоте, они объединены в один модуль, и это _не модуль
обработки_, он не участвует цепочке обработки и не попадает в историю, это _служебный модуль_, и находится он в _левой_
панели.

По кнопке «process» генерируется отдельный новый файл — TIFF в случае «denoise» и «upscale», и DNG — в случае «raw denoise».
По умолчанию он размещается рядом с исходным и сразу регистрируется в библиотеке.

За исходник «raw denoise» берет исходное состояние RAW-файла, тогда как «denoise» и «upscale» — результат всех примененных
обработок. Что, безусловно, логично, но не консистентно. К то­му же конкретно для «denoise» это неудобно — по идее это действие
должно быть внутри цепочки, ближе к началу... Я недоучел этот момент, когда делал свои тесты (о чем ниже), но переделывать
не буду — «правильный» порядок действий слишком заморочный, чтобы реальный пользователь им занимался.

### Где взять?

Тут есть засада: если вы как порядочный человек просто обновитесь из своего дистрибутива, не факт, что новые фичи у вас появятся.
У меня в Gentoo, например, не появились. Требуется сборка с дополнительным флагом, и когда мейнтейнеры разберутся — неизвестно.
Поэтому самый простой способ — скачать [официальный релиз с GitHib][download]. Для Linux там имеется AppImage, и он у меня заработал.

Затем нужно зайти в настройки.

{% image @_src/2026/07/ai-darktable/20260724_173940.png figure center width=900px crop=1221x560+64+52
         title="Скриншот настроек" %}

+ Включаем вверху галочку «enable AI features».

+ Скачиваем модели. Все, или только дефолтные.

+ Закрываем Darktable и запускаем его снова.

Отдельный вопрос: как включить выполнение на GPU. По идее, нужно установить ONNX и радоваться, но у меня не получилось — ONNX установил,
но он не цепляется. Для пробы это не критично, да и для использования — не так, чтобы очень — если нужно обработать небольшое количество
фотографий, скорость на CPU вполне терпима.

## Что получилось?

TL;DR

: + Как работает *raw denoise* мне в целом понравилось, это сильно лучше шумоподавления в стандартных модулях.

  + А вот *denoise* просто на высоких ISO порождает артефакты. _Отчасти_ эти артефакты могут усиливаться тем, что у ме­ня по умолчанию
    включен локальный контраст, а *denoise*, как сказано выше, берет уже обработанное изображение.

  + Что касается *upscale*... Я не понял. Если брать 100% кроп, то какого-то улучшения деталей в сравнении с тупым увеличением при экспорте
    (там можно разрешить увеличение). Общая картинка выглядит пошарпленной, но это опять же может быть вызвано двойным применением локального
    контраста.

Ниже *много* тестовых картинок.

<!--more-->

### Шумодавы

Ниже на разных ISO показаны результаты работы шумоподавления. Порядок такой: без шумодава, AI raw denoise, AI denoise. стандартный модуль raw denoise,
стандартный модуль denoise (profiled). В посте я показываю кроп, по клику откроется большая картинка, ужатая до 1800x1800px.

#### ISO 3200

Это то, что я на своей камере считаю максимальным условно рабочим ISO — шум заметен, но для информационных фото приемлем. Всё, что выше,
я не использую — автоматика ограничена на этом значении.

{:style="text-align:center;"}
{% image @_src/2026/07/ai-darktable/ISO3200.jpg width=280px crop="280x280+840+2220" title="ISO3200, оригинал"
         bounds=1800x1800 style="margin: 5px;" %}
{% image @_src/2026/07/ai-darktable/ISO3200_ai_raw-denoise.jpg width=280px crop="280x280+840+2220" title="ISO3200, AI raw denoise"
         bounds=1800x1800 style="margin: 5px;" %}
{% image @_src/2026/07/ai-darktable/ISO3200_ai_denoise.jpg width=280px crop="280x280+840+2220" title="ISO3200, AI denoise"
         bounds=1800x1800 style="margin: 5px;" %}
{% image @_src/2026/07/ai-darktable/ISO3200_std_raw.jpg width=280px crop="280x280+840+2220" title="ISO3200, std raw denoise"
         bounds=1800x1800 style="margin: 5px;" %}
{% image @_src/2026/07/ai-darktable/ISO3200_std_denoised.jpg width=280px crop="280x280+840+2220" title="ISO3200, std denoise profiled"
         bounds=1800x1800 style="margin: 5px;" %}

#### ISO 12800

{:style="text-align:center;"}
{% image @_src/2026/07/ai-darktable/ISO12800.jpg width=280px crop="280x280+1050+2250" title="ISO12800, оригинал"
         bounds=1800x1800 style="margin: 5px;" %}
{% image @_src/2026/07/ai-darktable/ISO12800_ai_raw-denoise.jpg width=280px crop="280x280+1050+2250" title="ISO12800, AI raw denoise"
         bounds=1800x1800 style="margin: 5px;" %}
{% image @_src/2026/07/ai-darktable/ISO12800_ai_denoise.jpg width=280px crop="280x280+1050+2250" title="ISO12800, AI denoise"
         bounds=1800x1800 style="margin: 5px;" %}
{% image @_src/2026/07/ai-darktable/ISO12800_std_raw_denoised.jpg width=280px crop="280x280+1050+2250" title="ISO12800, std raw denoise"
         bounds=1800x1800 style="margin: 5px;" %}
{% image @_src/2026/07/ai-darktable/ISO12800_std_profiled.jpg width=280px crop="280x280+1050+2250" title="ISO12800, std denoise profiled"
         bounds=1800x1800 style="margin: 5px;" %}

#### ISO 51200

{:style="text-align:center;"}
{% image @_src/2026/07/ai-darktable/ISO51200.jpg width=280px crop="280x280+1030+2180" title="ISO51200, оригинал"
         bounds=1800x1800 style="margin: 5px;" %}
{% image @_src/2026/07/ai-darktable/ISO51200_ai_raw-denoise.jpg width=280px crop="280x280+1030+2180" title="ISO51200, AI raw denoise"
         bounds=1800x1800 style="margin: 5px;" %}
{% image @_src/2026/07/ai-darktable/ISO51200_ai_denoise.jpg width=280px crop="280x280+1030+2180" title="ISO51200, AI denoise"
         bounds=1800x1800 style="margin: 5px;" %}
{% image @_src/2026/07/ai-darktable/ISO51200_std_raw.jpg width=280px crop="280x280+1030+2180" title="ISO51200, std raw denoise"
         bounds=1800x1800 style="margin: 5px;" %}
{% image @_src/2026/07/ai-darktable/ISO51200_std_profiled.jpg width=280px crop="280x280+1030+2180" title="ISO51200, std denoise profiled"
         bounds=1800x1800 style="margin: 5px;" %}

### Upscale

Первая картинка — увеличение через стандартный экспорт, вторая — AI upscale.

{:style="text-align:center;"}
{% image @_src/2026/07/ai-darktable/ISO100_std_upscale.jpg width=400px crop="400x400+1900+2590" title="Увеличение x2 стандартный экспорт"
         bounds=3200x3200 style="margin: 5px;" %}
{% image @_src/2026/07/ai-darktable/ISO100_ai_upscale-2x.jpg width=400px crop="400x400+1900+2590" title="Увеличение x2 AI"
         bounds=3200x3200 style="margin: 5px;" %}

Разница как бы есть... Но не особо понятна. Но учитывая, что я видел и такие ai-апскейлеры, которые делают *хуже*, чем простое увеличение...

## Итого

В общем, неплохо. Хотя для себя интересным я вижу только *raw denoise*, да и тем буду пользоваться редко.

С одной стороны, было бы неплохо встроить эти операции в цепочку обработки. С другой стороны — они медленные, точ­нее — вообще ресурсоемкие,
а цепочка обработки в процессе вычисляется много-много раз...

Посмотрим, к чему Darktable будет двигаться, мне почему-то кажется текущее состояние не окончательным.

[release]: https://www.darktable.org/2026/06/darktable-5.6.0-released/
[download]: https://github.com/darktable-org/darktable/releases/tag/release-5.6.0
