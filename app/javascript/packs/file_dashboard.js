setTimeout(() => {
  document.querySelector('.notice').textContent = "";
}, 10000);
self.selectedStyle = "border-orange text-orange border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 whitespace-nowrap pb-4 px-1 border-b-2 font-medium text-lg";
self.notSelectedStyle = "border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 whitespace-nowrap pb-4 px-1 border-b-2 font-medium text-lg"
self.activePane = null;
self.activePane = "manage";
document.querySelector("#file-navpane").addEventListener('click', e => {
  e.preventDefault();
  console.log('clicked');
  let a = e.target.closest('a');
  if (a) {
    let refId = a.dataset.ref
    if (refId == self.activePane) {
      return;
    }
    let pane = document.querySelector(`#${refId}`);
    pane.classList.remove("hidden");
    pane.classList.add("active");
    let previousActivePane = document.querySelector(`[data-ref="${self.activePane}"`);
    let currentActivePane = document.querySelector(`[data-ref="${refId}"`);
    previousActivePane.className = self.notSelectedStyle;
    currentActivePane.className = self.selectedStyle;
    

    document.querySelector(`#${self.activePane}`).classList.add("hidden");
    document.querySelector(`#${self.activePane}`).classList.remove("active");
    // document.querySelector(`[data-ref="${self.activePane}"`).class.replace(self.selectedStyle, "");
    // document.querySelector(`[data-ref="${self.activePane}"`).class += self.notSelectedStyle;
    // document.querySelector(`[data-ref="${refId}"`).class += self.selectedStyle;
    // document.querySelector(`[data-ref="${refId}"`).class.replace(self.notSelectedStyle, "");
    self.activePane = refId;
  }
});
document.querySelector("#clear").addEventListener('click', e => {
  e.preventDefault();
  document.querySelector("#message").value = ""
});

self.copyButtons = document.querySelectorAll(".copy-btn");
Array.from(self.copyButtons).forEach(copyButton => {
  let code = copyButton.previousElementSibling;
  copyButton.addEventListener('click', e => {
    e.preventDefault();
    navigator.permissions.query({name: "clipboard-write"}).then(result => {
      if (result.state == "granted" || result.state == "prompt") {
        navigator.clipboard.writeText(code.value);
      }
    });
    copyButton.textContent = "copied";
    setTimeout(() => copyButton.textContent = "copy to clipboard", 1000);
  });
});

self.sendAgainButtons = document.querySelectorAll(".send-again-btn");
Array.from(self.sendAgainButtons).forEach(sendAgainButton => {
  let recipient = sendAgainButton.dataset.recipient;
  let recipientId = sendAgainButton.dataset.recipientId;
  let documentId = sendAgainButton.dataset.documentId;
  sendAgainButton.addEventListener('click', e => {
    e.preventDefault();
    let confirmation = confirm(`This will send another email to ${recipient}. Are you sure?`);
    if (confirmation) {
      sendAgainButton.innerHTML = "<strong>Sending...</strong>";
      let xhr = new XMLHttpRequest();
      xhr.open("GET", `/distributeagain?recipient_id=${recipientId}&document_id=${documentId}`);
      // xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
      xhr.addEventListener('load', e => {
        e.preventDefault();
        sendAgainButton.innerHTML = "<strong>Message is on the way!</strong>";
        setTimeout(() => {
          sendAgainButton.innerHTML = "Send Again";
        }, 2000);
        console.log("email sent");
      });
      xhr.send();
    }
  });
});