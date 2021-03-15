(function () {
  const TOP_LEVEL_COMMENT_PROMPT = 'Будет добавлен комментарий верхнего уровня.';

  const PATH = "/admin/last-comments.json";
  const INTERVAL = 2000;
  const SLUG = document.getElementById("slug").value;

  function make(html) {
    let template = document.createElement("template");
    template.innerHTML = html.trim();
    let result = template.content.firstChild;
    result.classList.add("loaded");
    console.log(result);
    return result;
  }

  function process(data) {
    data.forEach((comment) => {
      let parent;
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
    if (window.location.hash == "#comments") {
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
    }
    setTimeout(check, INTERVAL);
  }

  function reset_answer(e) {
    let header = document.getElementById("comment-form-header");
    let field = document.getElementById("parent_id");
    header.innerHTML = 'Будет добавлен комментарий верхнего уровня';
    field.value = '';
  }

  function answer_action(e) {
    let target = e.target;
    let action = target.dataset.action;
    let comment_id = target.dataset.comment;
    let header = document.getElementById('comment-form-header');
    let field = document.getElementById('parent_id');
    header.innerHTML = `Будет добавлен ответ на комментарий <a href="#${comment_id}">#${comment_id}</a> [<a id="action-reset" style="cursor: pointer;" data-action="reset">сбросить</a>]`;
    field.value = comment_id;

    let message = document.getElementById("comment_message");
    if (action == 'cite') {
      let source = document.getElementById(comment_id).getElementsByClassName('comment-message')[0];
      let source_lines = source.textContent.trim().split('\n');
      for (let line of source_lines) {
        message.value += '\r\n> ' + line.trim();
      }
      message.value += "\r\n";
    }
    message.scrollIntoView({ block: "nearest", inline: "nearest" });

    let reset_a = document.getElementById('action-reset');
    reset_a.addEventListener('click', reset_answer);
  }

  function init_answers() {
    let ans_bars = document.getElementsByClassName("comment-actions");
    for (let bar of ans_bars) {
      bar.style.display = "block";
      for (let el of bar.children) {
        if (el.dataset.action == 'answer' || el.dataset.action == 'cite') {
          el.addEventListener('click', answer_action);
        }
      }
    }
  }

  function init_id() {
    var new_id = Math.floor(Math.random() * 16 * 16 * 16 * 16 * 16 * 16).toString(16);
    var field = document.getElementById('comment_id');
    field.value = new_id;
  }

  function init() {
    init_answers();
    setTimeout(check, INTERVAL);
  }

  // а вот это должно работать везде!
  init_id();

  if (self.fetch) {
    // в старых браузерах работать не будет, но это их проблемы
    window.addEventListener("load", init);
  }
})();
