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