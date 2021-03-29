function addValidationError(inputElement, validationError, login=false, pword=false) {
	// format input with Tailwinds consistent formatting
	inputElement.classList.remove('border-navy');
	inputElement.classList.add('text-red-600', 'border-red-600');
	let warningDialogue = inputElement.nextElementSibling;
	if (warningDialogue) {
		return;
	} else {
		// create new element to display error message
		warningDialogue = document.createElement('p');
		// style that message with tailwinds consistent formatting
		warningDialogue.innerText = validationError;
		warningDialogue.classList.add(
			'invalid',
			'p-2',
			'flex-1',
			'block',
			'w-full',
			'min-w-0',
			'rounded-md',
			'sm:text-sm',
			'bg-red-200',
			'text-red-600',
			'font-semibold',
			'border-2',
			'border-red-600'
		);
		// insert after related input
		if (login) {
			let loginForm = document.querySelector('#login-inputs');
			loginForm.insertAdjacentElement('afterend', warningDialogue);
		} else if (pword) {
			let passwordInputs = document.querySelector('#password-inputs');
			passwordInputs.insertAdjacentElement('afterend', warningDialogue);
		} else {
			inputElement.insertAdjacentElement('afterend', warningDialogue);
		}
	}
}

function removeValidationError(inputElement, login=false) {
	inputElement.classList.remove('text-red-600', 'border-red-600');
	inputElement.classList.add('border-navy');
	let warningDialogue = inputElement.nextElementSibling;
	let loginAlerts = Array.from(document.querySelectorAll('.invalid'));

	if (login && loginAlerts) {
		loginAlerts.forEach((alert) => alert.remove());
	}

	if (warningDialogue && !login) {
		warningDialogue.remove();
	}
}

const validationTable = {
	nameRegex            : /^[A-Za-z][A-Za-z '-]*$/,
	emailRegex           : /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i,
	passwordRegex        : /^.*(?=.{8,})(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!#$%&?" ]).*$/,
	fileRegEx            : /^[\d|\w]+[\d|\w|.| -]+[\d|\w]+$/,

	firstName            : function(input) {
		if (input.match(this.nameRegex)) {
			return true;
		} else if (input == '') {
			return 'Please enter a first name';
		} else {
			return 'Please use only letters, dashes, spaces, and commas';
		}
	},

	lastName             : function(input) {
		if (input.match(this.nameRegex)) {
			return true;
		} else if (input == '') {
			return 'Please enter a last name';
		} else {
			return 'Please use only letters, dashes, spaces, and commas';
		}
	},
	email                : function(input) {
		if (input.match(this.emailRegex)) {
			return true;
		} else if (input == '') {
			return 'Please enter an email';
		} else {
			return 'Please enter a valid email';
		}
	},

	emailList            : function(input) {
		const emails = input.split(',').map((email) => email.trim());
		for (const email of emails) {
			if (this.email(email) != true) {
				return "Please make sure all email addresses are valid and multiple emails are separated by ', ' !";
			}
		}
		return true;
	},

	password             : function(input) {
		if (input.match(this.passwordRegex)) {
			return true;
		} else if (input == '') {
			return 'Please enter a password';
		} else {
			return 'Passwords must be at least 8 characters long and contain at least 1 of each: lowercase, uppercase, number, special characters ( !#$%&?" )';
		}
	},

	passwordConfirmation : function(input) {
		let password = document.querySelector('#user_password');
		if (input == password.value) {
			return true;
		} else {
			return 'Passwords do not match';
		}
	},

	fileName             : function(input) {
		let fileName = input;
		if (fileName.length >= 3 && this.fileRegEx.test(fileName)) {
			return true;
		} else {
			return "File names need to be at least 3 characters long, START and END with a letter or number, and only contain letters, numbers, '.' , '-' , and spaces!";
		}
	},

	uploadFile           : function(input) {
		if (input.length > 1) {
			return true;
		} else {
			return 'Please select a file to beam up to our cloud!';
		}
	}
};

export { addValidationError, removeValidationError, validationTable };
