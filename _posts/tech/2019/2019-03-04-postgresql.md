---
layout: post
title: Всё для людей!
date: 2019-03-04
categories: [ tech, programming, db ]
tags:
  - базы данных
  - программирование
  - PostgreSQL
  - SQL
author: Иван Шихалев
description: Простые обновляемые представления в PostgreSQL
---
Ковыряюсь тут с **[PostgreSQL][pg]** и вот какую замечательную штуку обнаружил...

Собственно, про существование *«updatable views»* я знал, и давно. Но пока не доводилось использовать.
И я думал, что для того, чтобы они заработали, нужно прописывать правила для всех действий. Однако нет —
простые представления делаются изменяемыми автоматически, т.е. пишем, например:

{% highlight sql %}
create table something_data (
       id      bigint       not null,
       name    varchar(200) not null,
       deleted boolean      not null default false,
       constraint pk_something primary key (id)
);
create unique index uq_something_name on something_data(name)
                                   where (deleted = false);

create view something as
       select id, name from something_data
        where deleted = false;
{% endhighlight %}

... и всё, этого достаточно — можно обращаться к представлению `something` так же, как к таблице — вставлять,
изменять, удалять по `id`.

<!--more-->

Отдельно хочу обратить внимание на индекс с выражением `where` — он контролирует уникальность поля, но на записи
с пометкой удаления этот контроль не распространяется, т.е. для того, кто работает с представлением, их как бы нет,
без скрытых эффектов. И да, если мы попробуем запросить данные из `something` с сортировкой по `name`, при достаточно
большом количестве записей этот индекс будет задействован, проверено.

Для полного счастья остаётся один штришок — таки переопределить одно правило:

{% highlight sql %}
create rule something_delete as
    on delete to something
    do instead
       update something_data
          set deleted = true
        where id = old.id;
{% endhighlight %}

Теперь удаление через представление будет лишь ставить пометку удаления в реальных данных.

Что это нам даёт? Например то, что мы можем дать «обычному» пользователю БД (скажем, тому, под которым ходит веб-приложение,
находящееся в страшном и опасном диком интернете) права на представление и не дать непосредственно на таблицу, таким образом
слегка себя обезопасив от *некоторых* непоправимых действий. Особенно, если это не просто приложение, а открытое API.
А админка пусть ходит под более уполномоченным пользователем.

Почему это нельзя сделать на уровне приложения? Ну... Можно. Но мне представляется, что вопрос, как обрабатывать *логическое*
удаление — через реальное удаление, или же через пометку, должен решаться на уровне хранения, а прикладной уровень стоит
от него абстрагировать.

В принципе, механизм правил для представлений очень мощный и позволяет много чего, но меня восхитило (и сподвигло написать
эту заметку) то, что в простых случаях всё делается очень просто и без лишних телодвижений.





[pg]: https://www.postgresql.org/