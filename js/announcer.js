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

                const link = elem.querySelector('a');
                if (link) {
                    link.href = data[key];
                    elem.style.display = '';
                }
            });
        })
        .catch(error => {
            console.error(error);
        });
});
