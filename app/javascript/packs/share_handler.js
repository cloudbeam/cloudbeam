const VALIDATION_ERRORS = {
	fileName            :
		"File names need to be at least 3 characters long, START and END with a letter or number, and only contain letters, numbers, '.' and spaces!",
	fileUpload          : 'Please select a file to beam up to our cloud!',
	emailAddressInvalid : "Please make sure all email addresses are valid and multiple emails are separated by ', ' !"
};

document.querySelector('#clear').addEventListener('click', (e) => {
	e.preventDefault();
	document.querySelector('#message').value = '';
});

function blankInputPresent(inputCollection) {
	for (const input of inputCollection) {
		if (blankInput(input)) {
			return true;
		}
	}
	return false;
}

function blankInput(inputElement) {
	return inputElement.value.length > 1;
}

function toggleInputs(inputCollection) {
	for (const input of inputCollection) {
		focusToggle(input);
	}
}

function focusToggle(inputElement) {
	inputElement.focus();
	inputElement.blur();
	console.log(inputElement, 'toggled');
}

function invalidInputsPresent() {
	return document.querySelectorAll('.invalid').length > 0;
}

function uploadNotEmpty(inputElement) {
	return inputElement.value.length > 0;
}

function validEmailAddress(email) {
	emailRegEx = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
	return email.match(emailRegEx);
}

function validEmailList(emailList) {
	const emails = emailList.split(',').map((email) => email.trim());
	if (emails.length < 1) return false;

	for (const email of emails) {
		if (!validEmailAddress(email)) {
			return false;
		}
	}

	return true;
}

function findBadEmails(emailList) {
	const emails = emailList.split(',').map((email) => email.trim());
	const badEmails = [];
	for (const email of emails) {
		if (!validEmailAddress(email)) {
			badEmails.push(email);
		}
	}

	return badEmails;
}

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

const submit = document.querySelector("button[type='submit']"),
	form = document.querySelector('form'),
	emails = document.querySelector('#recipients'),
	targetInputs = [ emails ];

document.addEventListener('focusout', (e) => {
	if (e.target == emails) {
		console.log('emails lost focus');
		if (validEmailList(emails.value)) {
			removeValidationError(emails);
			console.log('error message removed from emails');
		} else {
			addValidationError(emails, VALIDATION_ERRORS['emailAddressInvalid']);
		}
	}
});

submit.addEventListener('click', (e) => {
	e.preventDefault();
	toggleInputs(targetInputs);
	if (invalidInputsPresent()) {
		alert('Please fix your information and we can continue.');
	} else {
		console.log(form);
		form.submit();
	}
});
