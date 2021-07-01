---

title: Сохраняем выделение
description: Как сохранить текущее выделение в contenteditable элементе при клике вне его.
category: [ tech, programming, web ]
tags:
  - CSS
  - HTML
  - JavaScript
---
Маленький рецептик — записать, чтоб не забыть, да и вдруг кому пригодится. Когда мы используем в HTML атрибут
`contenteditable`, может возникнуть желание (и почти наверняка возникнет) сохранять выделение редактируемого
текста при кликах снаружи (например, на какие-нибудь кнопки). Сделать это можно например так:

{% highlight javascript %}
var saved = null;

function storeSelection(e) {
  var main = document.getElementById('main');
  var current = e.target;
  var compare = main.compareDocumentPosition(current);
  if (compare != 0 && (compare & 16) == 0) {
    var range = window.getSelection().getRangeAt(0);
    saved = {
      startContainer : range.startContainer,
      startOffset : range.startOffset,
      endContainer : range.endContainer,
      endOffset : range.endOffset
    };
  }
}

function restoreSelection(e) {
  var main = document.getElementById('main');
  var current = e.target;
  var compare = main.compareDocumentPosition(current);
  if (saved && compare != 0 && (compare & 16) == 0) {
    var range = document.createRange();
    range.setStart(saved.startContainer, saved.startOffset);
    range.setEnd(saved.endContainer, saved.endOffset);
    var selection = window.getSelection();
    selection.removeAllRanges();
    selection.addRange(range);
  }
}

window.addEventListener('load', function(e) {
  var body = document.body;
  body.addEventListener('mousedown', storeSelection, false);
  body.addEventListener('mouseup', restoreSelection, false);
}, false);
{% endhighlight %}

Это, конечно, крайне примитивный пример, который, скажем, не проверяет, что выделение само по себе находится
в редактируемой области, проверяет только то, что клик не в ней.

В принципе, механизм очевиден, пояснения по методу `compareDocumentPosition()` можно найти в [документации Mozilla][moz],
или на [JavaScript.ru][jsr].

В процессе довелось столкнуться с интересным моментом — при абсолютном позиционировании элементов на странице
могут быть области ничем не покрытые, в т.ч. и элементом `body`. Соответственно, обработчик события на них
не срабатывает, и выделение сбрасывается. Чтобы этого не происходило, я использовал CSS:

{% highlight css %}
body {
  position : absolute;
  top : 0px;
  bottom : 0px;
  left : 0px;
  right : 0px;
  padding : 0px;
  margin : 0px;
}
{% endhighlight %}

Демо-пример целиком можно взять по адресу: <https://gist.github.com/shikhalev/6246433>.


[moz]: https://developer.mozilla.org/ru/docs/DOM/Node.compareDocumentPosition
[jsr]: http://learn.javascript.ru/compare-document-position
