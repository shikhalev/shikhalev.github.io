document.addEventListener('DOMContentLoaded', () => {
    fetch('/data/announced.json')
        .then(response => {
            if (!response.ok) throw new Error('JSON load error');
            return response.json();
        })
        .then(json => {
            document.querySelectorAll('.announcer-block').forEach(elem => {
                const channel = elem.getAttribute('data-channel');
                console.log({channel: channel})
                if (!channel || !(channel in json)) return;
                const data = json[channel];
                console.log({data: data})

                const key = elem.getAttribute('data-key');
                console.log({key: key})
                if (!key || !(key in data)) return;

                // const link = elem.querySelector('a');
                // if (link) {
                //     link.href = data[key];
                //     elem.style.display = '';
                // }
                const match = data[key].match(/t\.me\/(.+)/);
                console.log({match:match})
                const discussion = match ? match[1] : null; // "shikhalev_blog/66"
                console.log({discussion:discussion});

                const script = document.createElement('script');
                script.async = true;
                script.src = 'https://telegram.org/js/telegram-widget.js?22';
                script.setAttribute('data-telegram-discussion', discussion);
                script.setAttribute('data-comments-limit', '5');
                script.setAttribute('data-width', '100%');
                script.setAttribute('data-dark', '0');
                script.setAttribute('data-color', '#3e5662');
                elem.appendChild(script);
                elem.style.display = '';
                console.log({Telegram:Telegram});
            });
        })
        .catch(error => {
            console.error(error);
        });
});
