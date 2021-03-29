import { addValidationError, removeValidationError, validationTable } from './validation_module.js';

const email = document.querySelector('#user_email');
const password = document.querySelector('#user_password');
const loginBtn = document.querySelector('#login-btn');

const inputs = {
	email    : email,
	password : password
};

function validateInput(inputName) {
	let inputElement = inputs[inputName];
	let inputValue = inputElement ? inputElement.value : null;
	let result = validationTable[inputName](inputValue);
	let login = inputElement.id === 'user_email' ||
							inputElement.id === 'user_password';

	removeValidationError(inputElement, login);
	if (result !== true) {
		addValidationError(inputElement, result, login);
		return false;
	} else {
		return true;
	}
}

for (let prop in inputs) {
	let element = inputs[prop];
	if (!element) break;
	element.addEventListener('keyup', (e) => {
		validateInput(prop);
	});
}

loginBtn.addEventListener('click', (e) => {
	for (let inputName in inputs) {
		let result = validateInput(inputName);
		if (!result) {
			e.preventDefault();
		}
	}
});
