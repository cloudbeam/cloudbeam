document.querySelector("#clear").addEventListener('click', e => {
  e.preventDefault();
  document.querySelector("#message").value = ""
});