import { addValidationError, removeValidationError, validationTable } from './validation_module.js';

const password = document.querySelector('#user_password');
const passwordConfirmation = document.querySelector('#password-confirmation');
const resetBtn = document.querySelector('#reset-btn');

const inputs = {
	password             : password,
	passwordConfirmation : passwordConfirmation
};

function validateInput(inputName) {
	let inputElement = inputs[inputName];
	let inputValue = inputElement.value;
	let result = validationTable[inputName](inputValue);
	let reset = inputElement.id === 'user_email' || inputElement.id === 'user_password';

	removeValidationError(inputElement, reset);
	if (result !== true) {
		addValidationError(inputElement, result, reset);
		return false;
	} else {
		return true;
	}
}

for (let prop in inputs) {
	let element = inputs[prop];
	element.addEventListener('blur', (e) => {
		e.preventDefault();
		validateInput(prop);
		if (prop == 'passwordConfirmation') {
			validateInput('password');
		} else if (prop == 'password') {
			validateInput('passwordConfirmation');
		}
	});
}

resetBtn.addEventListener('click', (e) => {
	for (let inputName in inputs) {
		let result = validateInput(inputName);
		if (!result) {
			e.preventDefault();
		}
	}
});
