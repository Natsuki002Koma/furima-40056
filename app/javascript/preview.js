function preview() {

  console.log("preview.jsが読み込まれました");
};
window.addEventListener('turbo:load', preview);
window.addEventListener('turbo:render', preview);