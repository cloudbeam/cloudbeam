self.email = document.querySelector('#user_email');
self.password = document.querySelector('#user_password');
self.loginForm = document.querySelector('#login-form');
self.loginBtn = document.querySelector('#login-btn');
self.inputs = {
  email: self.email,
  password: self.password
};

self.validationTable = {
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
  let inputValue = self.inputs[inputName].value;
  let result = self.validationTable[inputName](inputValue);
  if (result !== true) {
    self.inputs[inputName].nextElementSibling.textContent = result;
    return false;
  }
  self.inputs[inputName].nextElementSibling.textContent = "";
  return true;
}

for (let prop in self.inputs) {
  let element = self.inputs[prop];
  element.addEventListener('blur', e => {
    e.preventDefault();
    validateInput(prop);
  });
}

self.loginBtn.addEventListener('click', e => {
  for (let prop in self.inputs) {
    let validation = validateInput(prop);
    if (!validation) {
      e.preventDefault();
    }
  }
});