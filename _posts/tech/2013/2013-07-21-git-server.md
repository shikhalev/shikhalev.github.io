---
title: "Кратко: примитивный git-сервер"
description: Настраиваем git-сервер для малых групп с минимальными затратами.
category: [ tech , soft, programming ]
tags:
  - администрирование
  - Gentoo
  - Git
image: /assets/img/2013-07/gitweb.png
recommend: true
---
{% include image.liquid place="right" width=320 src="/assets/img/2013-07/gitweb.png" style="margin-bottom:-5px;" %}

Сначала немного об окружении. Во-первых, предполагается наличие доступа на сервер по SSH, причем управление
доступом стандартное: через `~/.ssh/authorized_keys`. Во-вторых, в моем случае на сервере уже стоит nginx;
впрочем, он понадобится только для веб-отображения (см. скриншот справа), без которого вполне можно обойтись.
В-третьих, как обычно, я все это делаю под Gentoo.

Теперь, что мы получим в результате. Управление репозиториями только ручное — нужно зайти на сервер под рутом,
создать реп и дать на него права. Аналогично с доступом. Веб-интерфейс предназначен только для просмотра, зато
обеспечивает трансляцию обновлений в RSS. Если требуется что-то большее, следует обратить внимание на **[GitLab][gitlab]**,
например.

Итак, первое, что нам понадобится, само собой, это установить Git. Поскольку мы хотим веб-интерфейс, нужно
включить флаги `cgi` и (опционально) `highlight`.

{% highlight console %}
# echo -e 'dev-vcs/git\tcgi highlight' >> /etc/portage/package.use/dev-vcs
# emerge git
{% endhighlight %}

Далее создадим пользователя, который будет владельцем наших репозиториев.

{% highlight console %}
# useradd -m -G users -s /usr/bin/git-shell git
{% endhighlight %}

В группу `users` его можно бы и не добавлять, это я по привычке. А вот установка в качестве шелла `git-shell`
осмысленная — теперь этот пользователь ничего, кроме собственно работы с репозиториями, сделать не сможет.
Тут, правда, есть небольшая проблема — создавать репозитории придется от рута, а затем менять владельца...

Добавляем ключи — для начала тех, кто имеет доступ к root-аккаунту.

{% highlight console %}
# cp ~/.ssh/authorized_keys /home/git/.ssh/
# chown git:git /home/git/.ssh/authorized_keys
{% endhighlight %}

Создадим собственно репозиторий.

{% highlight console %}
# cd /home/git
# git init --bare repo.git
# chown -R git:git repo.git
{% endhighlight %}

Всё, с ним можно работать по SSH, используя адрес `git@server:repo.git`. Если, конечно, ваш публичный ключ
внесен в авторизованные... Чтобы разрешить неавторизованный доступ на чтение (если он, конечно, нужен),
воспользуемся `git-daemon`. Изменим в `/etc/conf.d/git-daemon` в строке `GITDAEMON_OPTS="--syslog --base-path=/var/git"`
«`/var/git`» на «`/home/git`». Затем запустим демон.

{% highlight console %}
# /etc/init.d/git-daemon start
# rc-update add git-daemon default
# touch /home/git/repo.git/git-daemon-export-ok
{% endhighlight %}

Последнюю команду следует выполнить для каждого репозитория, который мы хотим сделать публичным. Остается убедиться,
что пользователь `nobody` (git-демон по умолчанию использует его, можно поменять в конфиге) имеет доступ к репозиторию
на чтение и не имеет на запись (при стандартных настройках так и должно быть), и можно пользоваться — `git clone git://server/repo.git`.
Теоретически при соответствующих правах доступ может быть и на запись — сам git-протокол ограничения не накладывает,
однако я с трудом себе представляю ситуацию, когда неавторизованный доступ на запись может быть полезен, разве что
в рамках локальной сети...

Другой способ дать всем доступ на чтение — по протоколу HTTP. Добавляем в `/etc/nginx/nginx.conf`:

{% highlight nginx %}
server {
        listen 80;
        server_name git.server;
        root /home/git;
}
{% endhighlight %}

И (пере-)запускаем nginx. Для конкретного репозитория, правда, нам понадобится активировать перехватчик `post-update`,
после чего сделать push с произвольными изменениями. Лучше всего его активировать сразу после создания репозитория,
примерно так:

{% highlight console %}
# mv repo.git/hooks/post-update.sample repo.git/hooks/post-update
{% endhighlight %}

Это даст возможность обращаться так: `git clone http://git.server/repo.git`.

Вот мы и подошли к веб-представлению. Вариант для Apache можно увидеть в [официальной документации][docs], меня же интересует nginx.
А тут проблема — nginx не поддерживает GCI, посему приходится устанавливать и использовать FastCGI-обертку. Пакет так и называется:

{% highlight console %}
# emerge fcgiwrap
{% endhighlight %}

Затем запускаем его командой:

{% highlight console %}
# fcgiwrap -s tcp:127.0.0.1:8088 -f &
{% endhighlight %}

А в `/etc/nginx/nginx.conf` добавим:

{% highlight nginx %}
upstream gitweb {
    server 127.0.0.1:8088;
}

server {
    listen 80;
    server_name gitweb.server;
    root /usr/share/gitweb;

    location ~* \.(jpg|txt|jpeg|gif|png|ico|css|zip|js|swf)$ {
        expires 0;
    }

    location / {
        fastcgi_pass gitweb;
        fastcgi_param QUERY_STRING $query_string;
        fastcgi_param REQUEST_METHOD $request_method;
        fastcgi_param REQUEST_URI $request_uri;
        fastcgi_param SCRIPT_FILENAME $document_root/gitweb.cgi;
    }
}
{% endhighlight %}

Осталось только настроить собственно GitWeb. Вот примерный `/etc/gitweb.conf`:

{% highlight perl %}
$projectroot = "/home/git/";
$site_name = "Git Server";
$feature{'highlight'}{'default'} = [1];
{% endhighlight %}

Последняя строчка напоминает нам, что мы имеем дело с языком Perl...

Завершающий, уже декоративный штрих: прописываем репозиторию краткое описание —
файл `description`, и имя владельца — переменная `owner` секции `[gitweb]` файла `config`
в каталоге репозитория.









[gitlab]: https://gitlab.org/
[docs]: git-scm.com/book/ru/v2/Git-на-сервере-GitWeb
