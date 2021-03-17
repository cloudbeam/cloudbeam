document.addEventListener('turbolinks:load', e => {
  const email = document.querySelector('#user_email');
  const password = document.querySelector('#user_password');
  const loginBtn = document.querySelector('#login-btn');

  if (!loginBtn) {
    return;
  }
  const inputs = {
    email: email,
    password: password
  };

  const validationTable = {
    email: function(input) {
      if (input.match(/^.+@.+$/)) {
        return true;
      } else if (input == "") {
        return "Please enter an email";
      } else {
        return "Please enter a valid email";
      }
    },

    password: function(input) {
      if (input == "") {
        return "Please enter a password";
      } else {
        return true;
      }
    }
  }

  function validateInput(inputName) {
    let inputValue = inputs[inputName].value;
    let result = validationTable[inputName](inputValue);
    if (result !== true) {
      inputs[inputName].nextElementSibling.textContent = result;
      return false;
    }
    inputs[inputName].nextElementSibling.textContent = "";
    return true;
  }

  for (let prop in inputs) {
    let element = inputs[prop];
    element.addEventListener('blur', e => {
      e.preventDefault();
      validateInput(prop);
    });
  }

  loginBtn.addEventListener('click', e => {
    console.log('clicked');
    for (let prop in self.inputs) {
      let validation = validateInput(prop);
      if (!validation) {
        e.preventDefault();
      }
    }
  });
});
