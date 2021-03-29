import { addValidationError, removeValidationError, validationTable } from './validation_module.js';

const firstName = document.querySelector('#user_first_name');
const lastName = document.querySelector('#user_last_name');
const email = document.querySelector('#user_email');
const password = document.querySelector('#user_password');
const passwordConfirmation = document.querySelector('#user_password_confirmation');
const signupBtn = document.querySelector('#signup-btn');

const inputs = {
	firstName            : firstName,
	lastName             : lastName,
	email                : email,
	password             : password,
	passwordConfirmation : passwordConfirmation
};

function validateInput(inputName) {
	let inputElement = inputs[inputName];
	let inputValue = inputElement.value;
	let result = validationTable[inputName](inputValue);
	let password = inputElement.id === 'user_password' ||
								 inputElement.id === 'user_password_confirmation';

	removeValidationError(inputElement, password);
	if (result !== true) {
		addValidationError(inputElement, result, false, password);
		return false;
	} else {
		return true;
	}
}

for (let inputName in inputs) {
	let element = inputs[inputName];

	element.addEventListener('keyup', (e) => {
		validateInput(inputName);
	});
}

signupBtn.addEventListener('click', (e) => {
	for (let prop in inputs) {
		let validation = validateInput(prop);
		if (!validation) {
			e.preventDefault();
		}
	}
});
