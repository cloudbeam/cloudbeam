import consumer from "./consumer"

consumer.subscriptions.create("DocumentRecipientChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    let hiddenIdField = document.querySelector(`[id="${data.recipient.id}"]`);
    if (hiddenIdField) {
      let recipientElement = hiddenIdField.nextElementSibling;
      console.log(recipientElement);
      recipientElement.textContent = "Yes";
      recipientElement.classList.add("flash-green");
      setTimeout(() => {
        recipientElement.classList.remove("flash-green");
      }, 2000);
    }
    let li = document.createElement('li');
    li.innerHTML = `${data.recipient.email} downloaded the file ${data.document.name} <button>x</button>`;
    
    
    document.querySelector('.alert-ul').appendChild(li);
    li.querySelector('button').addEventListener('click', e => {
      e.preventDefault();
      li.remove();
    })
    
    // setTimeout(() => {
    //   li.remove();
    // }, 5000);
  }
});
