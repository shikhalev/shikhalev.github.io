console.log({kinds: window.goodKinds});
document.addEventListener('DOMContentLoaded', () => {
  if (window.goodKinds) {
    const container = document.getElementById('filter-container');
    console.log({container: container});
    if (container) {
      const root = window.goodKinds['@root'];
      console.log({root: root, kinds: window.goodKinds});
      const fillData = function (node) {
        node.valid = [];
        node.valid.push(node.path);
        if (node.children && node.children.length > 0) {
          node.children.forEach(child => {
            const childNode = window.goodKinds[child];
            fillData(childNode);
            node.valid.push(... childNode.valid);
          });
        }
      }
      fillData(root);
      const applyFilterValue = function (value) {
        if (value == 'null') {
          value = null;
        }
        const cards = document.querySelectorAll('.product-min-card');
        let counter = 0
        if (value) {
          const valid = window.goodKinds[value].valid;
          cards.forEach(card => {
            const kind = card.dataset.kind;
            if (valid.includes(kind)) {
              card.style.display = '';
              counter = counter + 1;
            } else {
              card.style.display = 'none';
            }
          });
        } else {
          cards.forEach(item => {
            item.style.display = '';
            counter = counter + 1;
          });
        }
        const counterSpan = document.getElementById('title-counter');
        counterSpan.innerHTML = counter.toString();
      }
      const createFilter = function (level, data, parentValue) {
        const select = document.createElement('select');
        select.dataset.level = level;
        select.dataset.parentValue = parentValue;
        const emptyOpt = document.createElement('option');
        emptyOpt.value = '';
        emptyOpt.textContent = '- (выберите категорию) -';
        select.appendChild(emptyOpt);
        data.children.forEach(item => {
          const option = document.createElement('option');
          option.value = item;
          const value = window.goodKinds[item];
          option.textContent = value.title; // + ' (' + value.count.toString() + ')';
          select.appendChild(option);
        });
        select.addEventListener('change', (event) => {
          // Удаляем лишнее.
          const items = container.querySelectorAll('select');
          items.forEach(item => {
            if (+item.dataset.level > +event.target.dataset.level) {
              item.remove();
            }
          });
          // Создаем следующий.
          if (event.target.value && event.target.value != '') {
            const selected = window.goodKinds[event.target.value];
            if (selected && selected.children && Array.isArray(selected.children) && selected.children.length > 0) {
              createFilter(+event.target.dataset.level + 1, selected, event.target.value);
            }
          }
          // Применяем фильтр.
          if (event.target.value && event.target.value != '') {
            applyFilterValue(event.target.value);
          } else {
            applyFilterValue(event.target.dataset.parentValue);
          }
        });
        container.appendChild(select);
      }
      createFilter(0, root, null);
    }
  }

  if (window.goodDesigns) {
    const container = document.getElementById('filter-container');
    if (container) {
      const root = window.goodDesigns['@root'];
      const fillData = function (node) {
        node.valid = [];
        node.valid.push(node.path);
        if (node.children && node.children.length > 0) {
          node.children.forEach(child => {
            const childNode = window.goodDesigns[child];
            fillData(childNode);
            node.valid.push(... childNode.valid);
          });
        }
      }
      fillData(root);
      const applyFilterValue = function (value) {
        if (value == 'null') {
          value = null;
        }
        const cards = document.querySelectorAll('.product-min-card');
        let counter = 0
        if (value) {
          const valid = window.goodDesigns[value].valid;
          cards.forEach(card => {
            const design = card.dataset.design;
            if (valid.includes(design)) {
              card.style.display = '';
              counter = counter + 1;
            } else {
              card.style.display = 'none';
            }
          });
        } else {
          cards.forEach(item => {
            item.style.display = '';
            counter = counter + 1;
          });
        }
        const counterSpan = document.getElementById('title-counter');
        counterSpan.innerHTML = counter.toString();
      }
      const createFilter = function (level, data, parentValue) {
        const select = document.createElement('select');
        select.dataset.level = level;
        select.dataset.parentValue = parentValue;
        const emptyOpt = document.createElement('option');
        emptyOpt.value = '';
        emptyOpt.textContent = '- (выберите категорию) -';
        select.appendChild(emptyOpt);
        data.children.forEach(item => {
          const option = document.createElement('option');
          option.value = item;
          const value = window.goodDesigns[item];
          option.textContent = value.title; // + ' (' + value.count.toString() + ')';
          select.appendChild(option);
        });
        select.addEventListener('change', (event) => {
          // Удаляем лишнее.
          const items = container.querySelectorAll('select');
          items.forEach(item => {
            if (+item.dataset.level > +event.target.dataset.level) {
              item.remove();
            }
          });
          // Создаем следующий.
          if (event.target.value && event.target.value != '') {
            const selected = window.goodDesigns[event.target.value];
            if (selected && selected.children && Array.isArray(selected.children) && selected.children.length > 0) {
              createFilter(+event.target.dataset.level + 1, selected, event.target.value);
            }
          }
          // Применяем фильтр.
          if (event.target.value && event.target.value != '') {
            applyFilterValue(event.target.value);
          } else {
            applyFilterValue(event.target.dataset.parentValue);
          }
        });
        container.appendChild(select);
      }
      createFilter(0, root, null);
    }
  }
});
