---
title: Что такое Free Pascal?
description: >-
  Free Pascal, точнее Free Pascal Compiler aka FPC — это свободный кроссплатформенный компилятор языка
  программирования Pascal. В отличие от другой свободной реализации этого языка — GNU Pascal, FPC ориентирован
  не на стандарт, а на популярные диалекты — то, что когда-то называлось Object Pascal, а теперь Delphi Language.
category: [ tech, programming, fpc ]
tags:
  - лицензии
  - Pascal
  - свободное ПО
  - компиляторы
  - языки программирования
image: /assets/img/2011-10/fpc/lazarus-over.png
---
<div class="right-box" style="width: 300px">
[![Скриншот IDE Lazarus][cover]][cover]
</div>

**Free Pascal** [[1]](/2011/10/what-is-free-pascal.html#site-fpc), точнее Free Pascal Compiler aka FPC — это свободный[^fpc-free] кроссплатформенный компилятор
языка программирования Pascal. В отличие от другой свободной реализации этого языка — GNU Pascal, FPC ориентирован
не на стандарт, а на популярные диалекты — то, что когда-то называлось Object Pascal, а теперь Delphi Language.

Существует также проект **Lazarus** [[2]](/2011/10/what-is-free-pascal.html#site-lazarus) — основанная на FPC свободная среда программирования, реализующая
значительную часть функционала собственно среды Borland Delphi (см. врезку). Простые проекты можно переносить практически
без ручной работы, после чего они могут быть скомпилированы для систем, отличных от Win32.

<!--more-->

## Поддерживаемые платформы

Список ниже неполон. Дело в том, что разработка компилятора ведется непрерывно и портирование его на различные платформы тоже.
Версии для разных платформ находятся в разных стадиях готовности, постоянно дорабатываются, а проверить их вживую у меня нет
никакой возможности. Поэтому я перечислю только те, в которых я более-менее уверен.

<div class="list-box">

* **x86 (aka i386, IA32)**
  * Linux
  * Win32
  * FreeBSD
  * Darwin (Mac OS X)
  * DOS (с «расширителями» для защищенного 32-разрядного режима)
    * Go32v2
    * WDOSX
    * Watcom-совместимые
  * OS/2
  * Netware
  * Solaris
* **x86-64 (aka AMD64, EM64T)**
  * Linux
  * Win64
  * FreeBSD
  * Darwin (Mac OS X)
  * Solaris
* **ARM**
  * Linux
  * Windows CE, Windows Mobile
  * Darwin (Mac OS X / iPhoneOS)
  * GameBoy Advance
  * Nintendo DS
  * PalmOS
  * SymbianOS
* **PowerPC**
  * Linux
  * Darwin (Mac OS X)
  * MacOS (classic)
  * Nintendo Wii
* **PowerPC64**
  * Linux
  * Darwin (Mac OS X)
* **SPARC**
  * Linux
  * Solaris

</div>

Не все из этого развито одинаково хорошо. За подробным списком с пояснениями, что и как, прошу на официальный сайт,
в викидокументацию [[3]](#site-platforms). Информация в pdf-документации, пожалуй, слишком скупа [[4, стр. 7–8]](#pdf-user).
Замечу, что чем менее «мейнстримна» ваша платформа, тем больше вероятность столкнуться с проблемами. Наиболее отлажены
и богаты библиотеками — самые распространенные системы: Windows, Linux, Mac OS X и FreeBSD.

В устаревших версиях компилятора 1.x, которые можно попытаться найти на ftp-зеркалах в интернете, поскольку на официальном
ftp-сервере [[5]](#site-ftp) они сейчас отсутствуют, была также поддержка архитектуры Motorola 680x0. В современных версиях
она отсутствует, и неизвестно, вернется ли. Скорее всего, никому особо-то и не нужно.

Отдельно стоит упомянуть о недавно запущенном проекте генерации кода для виртуальной Java-машины. В релиз эта возможность
еще не попала, желающие могут обратиться к викидокументации [[6]](#site-java).

## Диалекты языка

TP
: режим совместимости с Turbo Pascal. Совместимость практически полная, за исключением тех средств Turbo Pascal,
  которые были возможны только в real-mode DOS.

Delphi
: режим совместимости с Borland Delphi. На сегодняшний день по языку[^lang] Free Pascal совместим с Delphi примерно 7-й версии.

FPC
: собственный диалект языка. Базируется на TP, от которого отличается различными расширениями, такими как, например,
  перегрузка операций. Включен по-умолчанию.

ObjFPC
: собственный диалект языка с объектно-ориентированными расширениями a-la Delphi. Рекомендуется для новых проектов.

MacPas
: режим совместимости с Macintosh Pascal.

Выбор текущего диалекта осуществляется через указание параметров компилятора, а также посредством директивы компилятора
`{$MODE xxx}` непосредственно в исходных файлах. В одном проекте, но в разных модулях, могут быть задействованы одновременно
любые диалекты.

Подробнее о различиях между поддерживаемыми диалектами и прочих расширениях языка пойдет речь в отдельной статье.

## Источники информации

Официальная документация на английском языке распространяется вместе с компилятором, а также доступна на официальном же
сайте FreePascal.org [[1]](#site-fpc). Там же находится вики, где можно найти дополнительную информацию — о новых,
экспериментальных и только планируемых возможностях.

Документация распространяется в формате PDF и состоит из следующих книг:

Free Pascal: Language Reference Guide [[7]](#pdf-ref)
: Справочное руководство по языку. Подробно описывает собственно язык, не включая стандартную библиотеку,
  которая документирована отдельно (см. ниже).

Free Pascal: Programmer’s Guide [[8]](#pdf-prog)
: Руководство программиста. Описывает различные тонкости, такие как: директивы компилятора, управление памятью,
  соглашения об использовании регистров, особенности различных платформ и т.д.

Free Pascal: User’s Guide [[4]](#pdf-user)
: Руководство пользователя. Описывает использование и настройки компилятора и входящих в дистрибутив утилит,
  включая IDE текстового режима, но исключая описание утилиты для генерации документации к модулям fpdoc,
  которой посвящено отдельное руководство (см. ниже).

  Также описывается отладка, сообщения об ошибках и проч.

Run-Time Library (RTL): Reference Guide [[9]](#pdf-rtl)
: Справочное руководство по стандартным модулям. Включает документацию на 46 модулей, входящих в состав RTL.

Free Component Library (FCL): Reference Guide [[10]](#pdf-fcl)
: Справка по дополнительным модулям, также входящим в стандартный набор, но не входящих в состав RTL. Подробнее о том,
  какие это модули и с чем их едят, мы поговорим в отдельной статье.

FPDoc: Reference Manual [[11]](#pdf-fpdoc)
: Справочное руководство по утилите автодокументирования исходников FPDoc.

Тем же, кто предпочитает русский язык, следует в первую очередь обратиться на сайт FreePascal.ru [[12]](#site-rus),
где наличествует ряд материалов (в основном статьи) и хороший живой форум [[13]](#forum-rus). Также могу порекомендовать
книги для начинающих [[14]](#rus-mansurov) и [[15]](#rus-derevenets).

{:#licenses}
## Лицензии

Компилятор как таковой распространяется на условиях GNU General Public License v2 [[16]](#gpl), тогда как идущие
в комплекте библиотеки — RTL и FCL — на условиях модифицированной GNU Lesser General Public License v2.1 [[17]](#lgpl).
Данная модификация явно разрешает статическую линковку с произвольным кодом [[18, п 1.4]](#site-faq). Также входящие
в комплект модули из каталогов `packages` могут использовать какие-то другие лицензии — тут лучше уточнять отдельно
в каждом конкретном случае.

Схожую картину можно наблюдать и в проекте Lazarus — IDE и утилиты под GPLv2, основные библиотеки — modified LGPL,
некоторые пакеты под своими лицензиями.

Итого: вы можете, используя Free Pascal и/или Lazarus, писать, как проприетарные, так и свободные (в том числе —
копилефтные) программы.

## Ссылки

<div class="links-box">

{:#site-fpc}
[1] Официальный сайт Free Pascal
<http://freepascal.org/> [en]

{:#site-lazarus}
[2] Официальный сайт Lazarus
<http://lazarus.freepascal.org/> [en]

{:#site-platforms}
[3] Перечень поддерживаемых платформ
<http://wiki.freepascal.org/Platform_list> [en]

{:#pdf-user}
[4] **Free Pascal: User’s Guide**
*Michaël Van Canneyt, Florian Klämpfl*
Файл: [[user.pdf]](ftp://ftp.freepascal.org/pub/fpc/docs-pdf/user.pdf) [en]

{:#site-ftp}
[5] Официальный ftp-сервер
<ftp://ftp.freepascal.org/pub/> [en]

{:#site-java}
[6] FPC for JVM
<http://wiki.freepascal.org/FPC_JVM> [en]

{:#pdf-ref}
[7] **Free Pascal: Language Reference Guide**
*Michaël Van Canneyt*
Файл: [[ref.pdf]](ftp://ftp.freepascal.org/pub/fpc/docs-pdf/ref.pdf) [en]

{:#pdf-prog}
[8] **Free Pascal: Programmer’s Guide**
*Michaël Van Canneyt*
Файл: [[prog.pdf]](ftp://ftp.freepascal.org/pub/fpc/docs-pdf/prog.pdf) [en]

{:#pdf-rtl}
[9] **Run-Time Library (RTL): Reference Guide**
*Michaël Van Canneyt*
Файл: [[rtl.pdf]](ftp://ftp.freepascal.org/pub/fpc/docs-pdf/rtl.pdf) [en]

{:#pdf-fcl}
[10] **Free Component Library (FCL): Reference Guide**
*Michaël Van Canneyt*
Файл: [[fcl.pdf]](ftp://ftp.freepascal.org/pub/fpc/docs-pdf/fcl.pdf) [en]

{:#pdf-fpdoc}
[11] **FPDoc: Reference Manual**
*Michaël Van Canneyt*
Файл: [[fpdoc.pdf]](ftp://ftp.freepascal.org/pub/fpc/docs-pdf/fpdoc.pdf) [en]

{:#site-rus}
[12] Сайт русскоязычного сообщества
<http://freepascal.ru/> [ru]

{:#forum-rus}
[13] Русскоязычный форум
<http://freepascal.ru/forum/> [ru]

{:#rus-mansurov}
[14] **Основы программирования в среде Lazarus**
*К. Т. Мансуров*
<http://mansurov-oshtu.ucoz.ru/> [ru]

{:#rus-derevenets}
[15] **Песни о Паскале**
*О. В. Деревенец*
<http://oleg-derevenets.narod.ru/> [ru]

{:#gpl}
[16] GNU General Public License, version 2
<http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt> [en]

{:#lgpl}
[17] GNU Lesser General Public License, version 2.1
<http://www.gnu.org/licenses/old-licenses/lgpl-2.1.txt> [en]

{:#site-faq}
[18] FAQ / Knowledge base
<http://freepascal.org/faq.var> [en]

</div>

[^fpc-free]: GNU General Public License, см. подраздел [«Лицензии»](/2011/10/what-is-free-pascal.html#licenses).

[^lang]: Совместимость стандартных библиотек менее полная.

[cover]: /assets/img/2011-10/fpc/lazarus-over.png
