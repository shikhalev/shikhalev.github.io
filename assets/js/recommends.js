document.addEventListener("DOMContentLoaded", () => {
  const random_item = (array) => {
    const size = array.length;
    const index = Math.floor(Math.random() * size);
    return array[index];
  };

  const random_two = (array) => {
    const size = array.length;
    const index1 = Math.floor(Math.random() * size);
    let index2 = Math.floor(Math.random() * (size - 1));
    if (index2 >= index1) {
      index2 += 1;
    }
    return [array[index1], array[index2]];
  };

  const make_item = (element, data) => {
    element.querySelector(".__new_recommends_image").src = data.image;
    element.querySelector(".__new_recommends_date_place").innerHTML = data.date;
    element.querySelector(".__new_recommends_title_place").innerHTML =
      data.title;
    element.querySelectorAll("a").forEach((elem) => {
      elem.href = data.url;
    });
  };

  const make_good_item = (element, data) => {
    element.querySelector(".__new_recommends_good_image").src = data.image;
    element.querySelector(".__new_recommends_date_place").innerHTML = data.good;
    element.querySelector(".__new_recommends_title_place").innerHTML =
      data.design;
    element.querySelectorAll("a").forEach((elem) => {
      elem.href = data.url;
    });
  };

  const filter_data = (data, flag, categories) => {
    console.log({ data: data, flag: flag, categories: categories });
    if (flag != "categories") {
      return data;
    }
    const result = data.filter((item) =>
      item.categories.some((cat) => categories.includes(cat)),
    );
    if (result.length < 2) {
      result.push(data[0]);
    }
    if (result.length < 2) {
      result.push(data.at(-1));
    }
    console.log({ result: result });
    return result;
  };

  container = document.querySelector(".__new_recommends");
  if (container) {
    fetch(container.dataset.main)
      .then((response) => {
        if (!response.ok) {
          throw new Error("Ошибка загрузки!");
        }
        return response.json();
      })
      .then((data) => {
        const filtered = filter_data(
          data,
          container.dataset.flag,
          container.dataset.categories.split(","),
        );
        const values = random_two(filtered);
        console.log({ values: values, data: data });
        const items = container.querySelectorAll(".__new_recommends_article");
        make_item(items[0], values[0]);
        make_item(items[1], values[1]);
      });

    fetch(container.dataset.goods)
      .then((response) => {
        if (!response.ok) {
          throw new Error("Ошибка загрузки!");
        }
        return response.json();
      })
      .then((data) => {
        const value = random_item(data);
        const item = container.querySelector(".__new_recommends_good");
        make_good_item(item, value);
      });

    container.querySelectorAll("figure").forEach((elem) => {
      elem.style.order = Math.floor(Math.random() * 10);
    });
  }
});
