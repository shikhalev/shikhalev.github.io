(function () {
  const PATH = "/admin/last-comments.json";
  const INTERVAL = 2000;
  const SLUG = document.getElementById("slug").value;

  function make(html) {
    var template = document.createElement("template");
    template.innerHTML = html.trim();
    var result = template.content.firstChild;
    result.classList.add("loaded");
    console.log(result);
    return result;
  }

  function process(data) {
    data.forEach((comment) => {
      var parent;
      if (comment.parent_id && comment.parent_id != "") {
        parent = document.getElementById(comment.parent_id);
      } else {
        parent = document.getElementById("comments");
      }
      if (parent) {
        parent.appendChild(make(comment.content));
      }
    });
  }

  function check() {
    fetch(PATH)
      .then((response) => response.json())
      .then((data) =>
        process(
          data.filter(
            (comment) =>
              comment.slug == SLUG &&
              !document.getElementById(comment.comment_id)
          )
        )
      );
    setTimeout(check, INTERVAL);
  }

  function init() {
    setTimeout(check, INTERVAL);
  }

  if (self.fetch) {
    // в старых браузерах работать не будет, но это их проблемы
    window.addEventListener("load", init);
  }
})();
