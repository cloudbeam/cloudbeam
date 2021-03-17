document.addEventListener('turbolinks:load', e => {
  const firstName = document.querySelector('#user_first_name');
  const lastName = document.querySelector('#user_last_name');
  const email = document.querySelector('#user_email');
  const password = document.querySelector('#user_password');
  const passwordConfirmation = document.querySelector('#user_password_confirmation');

  const signupBtn = document.querySelector('#signup-btn');
  if (!signupBtn) {
    return;
  }
  const inputs = {
    firstName: firstName,
    lastName: lastName,
    email: email,
    password: password,
    passwordConfirmation: passwordConfirmation
  };

  const validationTable = {
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
      if (input == password.value) {
        return true;
      } else {
        return "Passwords do not match";
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
      if (prop == "passwordConfirmation") {
        validateInput("password");
      } else if (prop == "password") {
        validateInput("passwordConfirmation");
      }
    });
  }

  signupBtn.addEventListener('click', e => {
    for (let prop in inputs) {
      let validation = validateInput(prop);
      if (!validation) {
        e.preventDefault();
      }
    }
  });
});
