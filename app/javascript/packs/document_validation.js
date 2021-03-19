const VALIDATION_ERRORS = {
	fileName   :
		"File names need to be at least 3 characters long, START and END with a letter or number, and only contain letters, numbers, '.', '-', and spaces!",
	fileUpload : 'Please select a file to beam up to our cloud!'
};

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
}

function invalidInputsPresent() {
	return document.querySelectorAll('.invalid').length > 0;
}

function validFileName(inputElement) {
	let fileName = inputElement.value;
	let fileRegEx = new RegExp(/^[\d|\w]+[\d|\w|.| -]+[\d|\w]+$/);
	return fileName.length >= 3 && fileRegEx.test(fileName);
}
function uploadNotEmpty(inputElement) {
	return inputElement.value.length > 0;
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

const submit = document.querySelector("input[type='submit']"),
	form = document.querySelector('form'),
	fileNameInput = document.querySelector('#document_name'),
	fileUploadInput = document.querySelector('#document_upload'),
	targetInputs = [ fileNameInput, fileUploadInput ];

document.addEventListener('focusout', (e) => {
	if (e.target === fileNameInput) {
		if (validFileName(fileNameInput)) {
			removeValidationError(fileNameInput);
		} else {
			addValidationError(fileNameInput, VALIDATION_ERRORS['fileName']);
		}
	} else if (e.target === fileUploadInput) {
		if (uploadNotEmpty(fileUploadInput)) {
			removeValidationError(fileUploadInput);
		} else {
			addValidationError(fileUploadInput, VALIDATION_ERRORS['fileUpload']);
		}
	}
});

submit.addEventListener('click', (e) => {
	const targetInputs = [ fileNameInput, fileUploadInput ];
	toggleInputs(targetInputs);
	if (invalidInputsPresent()) {
		e.preventDefault();
		alert('Please fix your information and we can continue.');
	}
});
