---
title:  Занимательная архивация – 2 — 7-zip vs Bzip2 vs XZ vs LZMA vs LZip...
description: Все-таки собрался и немного потестил разные архиваторы
category:
  - tech
  - soft
tags:
  - 7-zip
  - архивация
  - Bzip2
  - LZip
  - LZMA
  - XZ
---
Все-таки собрался и немного потестил разные архиваторы. Результат в табличке.

<!-- TODO: fix link -->
<table class="wide">
 <tr>
  <th>&nbsp;</th>
  <th colspan="2">
<a href="http://freepascal.ru/news/20101027152132/">Набор примеров
для&#160;учебника по&#160;Lazarus</a>
(<a href="{% link _posts/tech/2010/2010-10-28-archivers.md %}">см.</a>)
  </th>
  <th colspan="2">Образ диска VirtualBox</th>
  <th colspan="2">Дерево исходных кодов Free&#160;Pascal с&#160;документацией</th>
 </tr>
 <tr>
  <th>Исходный размер</th>
  <td colspan="2" align="center">56.1M</td>
  <td colspan="2" align="center">8.8G</td>
  <td colspan="2" align="center">297M</td>
 </tr>
 <tr>
  <th>7z (<i>t</i>/size)</th>
  <td align="center">20.0s (17s)</td>
  <td align="center">411K</td>
  <td align="center">107m (80m)</td>
  <td align="center">2.8G</td>
  <td align="center">3m55s (2m52s)</td>
  <td align="center">125M</td>
 </tr>
 <tr>
  <th>tar.bz2</th>
  <td align="center">53.6s</td>
  <td align="center">9.3M</td>
  <td align="center">67m</td>
  <td align="center">3.5G</td>
  <td align="center">2m28s</td>
  <td align="center">134M</td>
 </tr>
 <tr>
  <th>tar.xz</th>
  <td align="center">30.1s</td>
  <td align="center">388K</td>
  <td align="center">133m</td>
  <td align="center">2.8G</td>
  <td align="center">4m40s</td>
  <td align="center">125M</td>
 </tr>
 <tr>
  <th>tar.lzma</th>
  <td align="center">30.0s</td>
  <td align="center">387K</td>
  <td align="center">132m</td>
  <td align="center">2.8G</td>
  <td align="center">4m45s</td>
  <td align="center">125M</td>
 </tr>
 <tr>
  <th>tar.lz</th>
  <td align="center">44.5s</td>
  <td align="center">388K</td>
  <td align="center">168m</td>
  <td align="center">2.8G</td>
  <td align="center">7m7s</td>
  <td align="center">125M</td>
 </tr>
 <tr>
  <th>tar.7z</th>
  <td align="center">21.1s (20s)</td>
  <td align="center">392K</td>
  <td align="center">107m</td>
  <td align="center">2.8G</td>
  <td align="center">4m22s</td>
  <td align="center">125M</td>
 </tr>
</table>

Поясню: время в таблице — это «user time», которое представляется единственно адекватным сравнению именно упаковщиков,
а не со­сто­я­ния системы в про­цес­се. В скобках же указано время «real», в том случае, если оно оказалось меньше «user».
Насколько я могу судить, это однозначно свидетельствует о том, что 7-zip задействовал для работы второе ядро. Правда,
отсутствие таких ситуаций у других программ сжатия еще ни о чем не говорит — я не выделял для тестирования какого-то
особого времени, а параллельно использовал компьютер в обычном режиме — с существенной, а главное — очень неравномерной нагрузкой...

Для тестирования я использовал следующий примитивный скрипт:

{% highlight bash %}
#!/bin/bash

src=$1

echo -e "source: $src\n"

tgt=$1.7z
echo -e "\ttarget: $tgt"
time ( 7z a "$tgt" "$src" > /dev/null )
ls -lh "$tgt"

tgt=$1.tar.bz2
echo -e "\ttarget: $tgt"
time ( tar -c --bzip2 -f "$tgt" "$src" > /dev/null )
ls -lh "$tgt"

tgt=$1.tar.xz
echo -e "\ttarget: $tgt"
time ( tar -c --xz -f "$tgt" "$src" > /dev/null )
ls -lh "$tgt"

tgt=$1.tar.lzma
echo -e "\ttarget: $tgt"
time ( tar -c --lzma -f "$tgt" "$src" > /dev/null )
ls -lh "$tgt"

tgt=$1.tar.lz
echo -e "\ttarget: $tgt"
time ( tar -c --lzip -f "$tgt" "$src" > /dev/null )
ls -lh "$tgt"

tgt=$1.tar.7z
echo -e "\ttarget: $tgt"
time ( tar -c --use-compress-program=p7zip -f "$tgt" "$src" > /dev/null )
ls -lh "$tgt"
{% endhighlight %}

Какие можно сделать выводы?

1. Результаты по первому набору данных не тождественны тем, которые у меня получались при использовании упаковки через контекстное
   меню Konqueror'а. Судя по всему, tar использует максимальное сжатие, в отличие от.

2. Результаты современных архиваторов очень близки друг к другу. 7-zip немного хуже сжимает, однако делает это заметно быстрее.
   Возможно, все дело вообще в настройках по-умолчанию.

3. «Устаревший» BZip2 работает заметно быстрее более новых форматов, за исключением все того же особого случая с при­ме­ра­ми.
   Как вариант для бэкапов я лично его в своем активе оставлю — иногда время тоже бывает существенным.

4. Хуже всего со временем у формата lzip при отсутствии сколь-нибудь заметного преимущества в степени сжатия. И, надо заметить,
   из рас­смот­рен­ных он, пожалуй, наименее популярен.
