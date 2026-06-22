---
permalink: /js/goods.js
layout:
---

document.addEventListener('DOMContentLoaded', () => {
    const kinds = {{ site.data.flat_goods | jsonify }};
    console.log({ KINDS: kinds });
});
