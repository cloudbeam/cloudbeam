function addValidationError(inputElement, validationError) {
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
		inputElement.insertAdjacentElement('afterend', warningDialogue);
	}
}

function removeValidationError(inputElement) {
	inputElement.classList.remove('text-red-600', 'border-red-600');
	inputElement.classList.add('border-navy');
	let warningDialogue = inputElement.nextElementSibling;
	if (warningDialogue) {
		warningDialogue.remove();
	}
}

const validationTable = {
	firstName            : function(input) {
		if (input == '') {
			return 'Please enter your first name';
		} else {
			return true;
		}
	},

	lastName             : function(input) {
		if (input == '') {
			return 'Please enter your last name';
		} else {
			return true;
		}
	},
	email                : function(input) {
		if (
			input.match(
				/^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i
			)
		) {
			return true;
		} else if (input == '') {
			return 'Please enter an email';
		} else {
			return 'Please enter a valid email';
		}
	},

	password             : function(input) {
		if (input == '') {
			return 'Please enter a password';
		} else {
			return true;
		}
	},

	passwordConfirmation : function(input) {
		if (input == password.value) {
			return true;
		} else {
			return 'Passwords do not match';
		}
	}
};

export { addValidationError, removeValidationError, validationTable };
