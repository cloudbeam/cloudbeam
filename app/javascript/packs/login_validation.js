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
	let inputValue = inputElement.value;
	let result = validationTable[inputName](inputValue);
	removeValidationError(inputElement);
	if (result !== true) {
		addValidationError(inputElement, result);
		return false;
	} else {
		return true;
	}
}

for (let prop in inputs) {
	console.log(prop);
	let element = inputs[prop];
	element.addEventListener('blur', (e) => {
		e.preventDefault();
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
