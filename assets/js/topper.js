(function () {
  const SCROLL_TOP = 120;

  function onScroll() {
    const topper = document.getElementById("topper");
    if (
      document.body.scrollTop > SCROLL_TOP ||
      document.documentElement.scrollTop > SCROLL_TOP
    ) {
      topper.style.display = "flex";
    } else {
      topper.style.display = "none";
    }
  }

  function onClick() {
    document.body.scrollTop = 0; // safari
    document.documentElement.scrollTop = 0;
    window.location.hash = '';
    history.pushState({}, document.title, window.location.href.split('#')[0]);
  }

  function init() {
    window.addEventListener("scroll", onScroll);
    onScroll();

    const topper = document.getElementById("topper");
    topper.addEventListener("click", onClick);
  }

  window.addEventListener("load", init);
})();
