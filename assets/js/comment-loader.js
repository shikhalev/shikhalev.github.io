if (self.fetch) {
  window.addEventListener("load", function (e) {
    // var slug = document.getElementById('slug').value;
    // var splash = document.getElementById('splash');
    // var comment_re = /^#\d{9}$/;

    // var i_pos = 0;
    // var intervals = [1000, 2000, 4000];

    // function check_comment() {
    //   // console.log({check_comment:i_pos});
    //   fetch("/admin/last-comments.json")
    //     .then((response) => {
    //       return response.json();
    //     })
    //     .then((data) => {
    //       for (var i = 0, l = data.length; i < l; i++) {
    //         var c = data[i];
    //         if (c.slug == slug && c.comment_id == comment_id) {
    //           window.location.reload();
    //         }
    //       }
    //       i_pos = i_pos + 1;
    //       if (i_pos <= intervals.length) {
    //         setTimeout(check_comment, intervals[i_pos - 1]);
    //       } else {
    //         splash.style.display = "none";
    //       }
    //     });
    // }

    // var comment_id = window.location.hash;
    // if (comment_id && comment_id != "" && comment_re.test(comment_id)) {
    //   comment_id = comment_id.substr(1);
    //   var element = document.getElementById(comment_id);
    //   if (!element) {
    //     splash.style.display = 'block';
    //     i_pos = 1;
    //     setTimeout(check_comment, intervals[0]);
    //   }
    // }
  });
}
