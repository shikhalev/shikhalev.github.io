---
title: Проблема интеграции Firefox с Plasma Desktop
description: Плагин Plasma Integration начал себя плохо вести...
category: [ tech, soft, dybr ]
tags:
  - Firefox
  - KDE
  - Linux
  - интеграция
  - DE
  - окружение рабочего стола
  - браузер
---
Недавно начал наблюдать пренеприятную штуку: при закрытии одновременно нескольких вкладок Firefox
начинает тормозить и жрать память, как не в себя. Уже на десятке-другом вкладок тормоза становятся
заметы, а сотня-другая просто отправляет систему в нокдаун на несколько минут. Именно при закрытии,
в процессе работы никаких проблем со множеством открытых вкладок у меня так и не возникло.

Я уже было начал задумываться о переходе на Chromium, но заметил, что тормозить начинает не только
Firefox, но и графическое окружение DE, то есть KDE Plasma... Итог — отключение расширения **[Plasma
Integration][plugin]** спасло ситуацию. Что там такое между ними происходит, я не очень понимаю.

Надо бы, конечно, поразбираться и написать им баг-репорт, но пока руки не доходят.

PS. При этом я понятия не имею, что вообще это расширение делает. Уведомления в трей Firefox пересылает
и без него.

[plugin]: https://addons.mozilla.org/ru/firefox/addon/plasma-integration/ "Add-On Plasma Integration"
