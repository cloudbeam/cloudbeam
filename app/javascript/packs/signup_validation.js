self.firstName = document.querySelector('#user_first_name');
self.lastName = document.querySelector('#user_last_name');
self.email = document.querySelector('#user_email');
self.password = document.querySelector('#user_password');
self.passwordConfirmation = document.querySelector('#user_password_confirmation');



self.signupBtn = document.querySelector('#signup-btn');
self.inputs = {
  firstName: self.firstName,
  lastName: self.lastName,
  email: self.email,
  password: self.password,
  passwordConfirmation: self.passwordConfirmation
};

self.validationTable = {
  firstName: function(input) {
    if (input == "") {
      return "Please enter your first name";
    } else {
      return true;
    }
  },

  lastName: function(input) {
    if (input == "") {
      return "Please enter your last name";
    } else {
      return true;
    }
  },
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
  },

  passwordConfirmation: function(input) {
    if (input == self.password.value) {
      return true;
    } else {
      return "Passwords do not match";
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

self.signupBtn.addEventListener('click', e => {
  for (let prop in self.inputs) {
    let validation = validateInput(prop);
    if (!validation) {
      e.preventDefault();
    }
  }
});