document.addEventListener("DOMContentLoaded", () => {
  const tracks = document.querySelectorAll(".suno_track");
  tracks.forEach((item) => {
    const frame = item.querySelector("iframe");
    const source = frame.src;
    item.addEventListener("toggle", () => {
      if (item.open) {
        frame.src = source;
      } else {
        frame.loading = 'eager';
        frame.src = "about:blank";
      }
    });
  });
});
