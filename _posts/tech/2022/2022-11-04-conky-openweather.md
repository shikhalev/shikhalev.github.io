---
title: Conky и OpenWeather
description: Подключил прогноз погоды от OpenWeather к Conky
category: 
    - tech
    - soft
    - web
tags:
    - Conky
    - OpenWeather
    - погода
    - мониторинг
image: /assets/img/2022-11/weather.png
---
{% include image.liquid place="right" width=489 src="/assets/img/2022-11/weather.png" title="Погода в Conky" link=false %}

Подключил прогноз погоды от **[OpenWeather][ow]** к Conky. Пока оно сыровато, надо продумать получше архитектуру, чтобы было удобно
пользоваться. Поэтому я не стал пока документировать этот модуль в [README][readme] **[репозитория][repo]{:.img-icon-github}**,
ну а в блоге можно и о том, что в процессе, написать.

У меня почему-то не получилось получить данные [текущей погоды][cur] с [OpenWeatherMap.org][ow], только [прогноз на пять дней с интервалом
3 часа][five]. Надо, конечно, поразбираться с их API получше — еще один повод не считать работу законченной...

Как бы то ни было, пятидневный прогноз вполне себе отображается. Как его использовать:

{:start="0"}
0. Мне потребовалось доустановить некоторые пакеты для Lua:

   * [`lua-cjson`][cjson] для парсинга ответа от сервера.
   * [`luaposix`][posix] для всякой вспомогательной работы с файлами и каталогами.
   * [`luasocket`][socket] для собственно загрузки по HTTP.

   В вашей системе это все может быть уже установлено, а может и не быть, нужно проверить и доустановить.

<!--more-->

1. Подключить так или иначе модуль [`openweather.lua`][module].

2. Создать файл `~/.config/conky/openweather_config.lua` (`api_key` выдается на [OpenWeatherMap.org][ow] при регистрации, можно определить 
   несколько мест (`places`)):

{% highlight lua %}
weather.config = {
    api_key = 'NNNNNNNNNNNNNNNNNNNNNNN',
    lang = 'ru',
    units = 'metric',
    places = {
        home = {
            latitude = YY.YYYYYY,
            longitude = XX.XXXXXX
        }
    }
}
{% endhighlight %}

{:start="3"}
3. Использовать в конфиге собственно Conky вызовы типа `${lua openweather_city_name home}` или `${lua openweather_weather_temp home 1}`,
   где `home` — это ключ места в `openweather_config.lua`, а `1` — индекс прогноза (собственно `1` — это ближайший — в Lua массивы индексируются
   с единицы).

   Конкретно на заглавной картинке отражен следующий фрагмент конфига, выводящий первые пять точек прогноза:

{% highlight conky %}
$alignc${color0}${font PT Sans:size=13}Weather$font
${lua openweather_city_name home} $alignr${lua openweather_city_id home}

${lua openweather_weather_time home 1 %H:%M}         ${lua openweather_weather_description home 1}${lua openweather_weather_icon_image home 1 50,1455}
                  ${lua openweather_weather_temp home 1}°C

${lua openweather_weather_time home 2 %H:%M}         ${lua openweather_weather_description home 2}${lua openweather_weather_icon_image home 2 50,1498}
                  ${lua openweather_weather_temp home 2}°C

${lua openweather_weather_time home 3 %H:%M}         ${lua openweather_weather_description home 3}${lua openweather_weather_icon_image home 3 50,1543}
                  ${lua openweather_weather_temp home 3}°C

${lua openweather_weather_time home 4 %H:%M}         ${lua openweather_weather_description home 4}${lua openweather_weather_icon_image home 4 50,1588}
                  ${lua openweather_weather_temp home 4}°C

${lua openweather_weather_time home 5 %H:%M}         ${lua openweather_weather_description home 5}${lua openweather_weather_icon_image home 5 50,1635}
                  ${lua openweather_weather_temp home 5}°C
${alignr}${font PT Mono:size=9}Updated: ${lua openweather_updated home %H:%M:%S}$font
{% endhighlight %}

В целом структура всего этого мне совсем не нравится. Думаю, вернуться к этому делу через некоторое время.

[ow]: https://openweathermap.org/
[repo]: https://github.com/shikhalev/conky
[readme]: https://github.com/shikhalev/conky/blob/main/README.md
[cur]: https://openweathermap.org/current
[five]: https://openweathermap.org/forecast5
[cjson]: https://github.com/openresty/lua-cjson
[posix]: https://github.com/luaposix/luaposix
[socket]: https://github.com/lunarmodules/luasocket
[module]: https://github.com/shikhalev/conky/blob/main/lua/openweather.lua
