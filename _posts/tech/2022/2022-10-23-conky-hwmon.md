---
title: "Conky: исправление проблемы с hwmon"
description: Скрипт автоопределения номера устройства hwmon по имени
category:
    - tech
    - soft
    - hard
tags:
    - Conky
    - Linux
    - администрирование
    - мониторинг
    - программирование
    - Lua
image: _src/2022/10/2022-10-24/conky-seo.svg
recommend: true
---
{% image @_src/2022/10/2022-10-24/conky.svg figure right width=240px
                             shape=true fig_class="logo" fig_style="shape-margin:20px;" link="https://github.com/brndnmtthws/conky" %}

Дано — известная многим программа **[Conky][conky]**, используемая в основном для мониторинга различных параметров системы, датчиков и т.д.
Собственно, с датчиками у меня и возникала регулярно проблема — выбор датчика в Conky производится по номеру, т.е. примерно так `${hwmon 1 temp 1}`;
при этом данный номер, как показывает практика, может меняться после каждой перезагрузки.

Вероятно, с этим можно как-то бороться через настройки, правила `eudev` или еще как. Но я пошел по пути наименьшего сопротивления и воспользовался
средствами Lua. Результат выложен в репозиторий **[conky][repo]{:.img-icon-github}**, конкретно — модуль [`hwmon`][module].

<!--more-->

## Как это работает

Полный код доступен [на GitHub][module].

Как выяснилось, в Lua можно использовать глобальные переменные, благодаря чему можно определить соответствие номеров и имен устройств
один раз, не тратя ресурсы при последующих вызовах. Поэтому, не заморачиваясь на оптимизации, перебираем все устройства `hwmon` и заносим их в таблицу,
используя имя (из файла `name`) как ключ, а индекс как значение.

Отдельный момент — это NVME — там для всех устройств используется одно имя (собственно «nvme»), и нужно их
как-то корректно различать. К счастью, способ есть — по пути `/sys/class/hwmon` находятся символические ссылки, которые указывают на соответствующие
подкаталоги внутри `/sys/devices`, где полный путь в случае NVME содержит номер устройства в системе. У меня это выглядит вот так:

{% highlight console %}
# ls -l /sys/class/hwmon
итого 0
lrwxrwxrwx 1 root root 0 окт 21 16:09 hwmon0 -> ../../devices/virtual/thermal/thermal_zone0/hwmon0
lrwxrwxrwx 1 root root 0 окт 21 16:09 hwmon1 -> ../../devices/pci0000:00/0000:00:01.1/0000:01:00.0/nvme/nvme0/hwmon1
lrwxrwxrwx 1 root root 0 окт 21 16:09 hwmon2 -> ../../devices/pci0000:00/0000:00:01.2/0000:02:00.2/0000:03:04.0/0000:06:00.0/nvme/nvme1/hwmon2
lrwxrwxrwx 1 root root 0 окт 21 02:42 hwmon3 -> ../../devices/pci0000:00/0000:00:18.3/hwmon/hwmon3
lrwxrwxrwx 1 root root 0 окт 21 02:42 hwmon4 -> ../../devices/pci0000:00/0000:00:03.1/0000:08:00.0/hwmon/hwmon4
lrwxrwxrwx 1 root root 0 окт 21 02:42 hwmon5 -> ../../devices/virtual/thermal/thermal_zone1/hwmon5
lrwxrwxrwx 1 root root 0 окт 21 02:42 hwmon6 -> ../../devices/platform/it87.2624/hwmon/hwmon6
{% endhighlight %}

Соответственно, посредством `readlink` несложно получить путь, из которого примитивно выделяется участок «nvmeN» (в Lua для этого используется
`:match('nvme%d+')`), который и добавляется в таблицу вместо имени.

Ну, а по итогу для получения значения датчика посредством метода `conky_parse()` вызывается стандартное выражение `${hwmon ...}` с индексом,
полученным из таблицы.

## Как это использовать

Для начала следует разместить модули `utils.lua` и `hwmon.lua` туда, где Conky их найдет. Ну, или прописать путь их размещения в Conky. Затем можно
просто загрузить модуль через `lua_load` или же подгрузить его в свой lua-модуль, если таковой используется.

Дальше в секции `TEXT` использовать:

{% highlight conky %}
${lua hwmon k10temp temp 1}
{% endhighlight %}

Или определить в своем lua-скрипте что-то типа:

{% highlight lua %}
function conky_cputemp()
    return conky_hwmon('k10temp', 'temp', 1)
end
{% endhighlight %}

Такой вариант позволит не только отображать значение через `${lua ...}`, но и отрисовывать его через `${lua_bar ...}` и `${lua_graph ...}`.

## PS. Температурные датчики it8686

По умолчанию ядро не поддерживает датчики на моей материнской плате, решение — установить сторонний модуль `it87`, как описано на сайте
[«Forza's ramblings»][forza]. Там сказано про материнские платы на базе чипсета B450, но и для моей [Gigabyte B550M AORUS PRO AX][mb] все прекрасно заработало.

[conky]: https://github.com/brndnmtthws/conky
[repo]: https://github.com/shikhalev/conky
[module]: https://github.com/shikhalev/conky/blob/main/lua/hwmon.lua
[forza]: https://wiki.tnonline.net/w/Blog/IT87_driver_for_the_it8686_sensor_chip "How to set add support for the IT8686 hardware monitoring chip on the Gigabyte B450M DS3H motherboard | Forza's Ramblings"
[mb]: https://aliclick.shop/s/67k9pg
