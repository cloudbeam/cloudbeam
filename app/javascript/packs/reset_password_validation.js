import { addValidationError, removeValidationError, validationTable } from './validation_module.js';

const email = document.querySelector('#email');
const sendBtn = document.querySelector('#send-reset');
const resetBtn = document.querySelector('#reset-btn');

const inputs = {
	email: email
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

email.addEventListener('keyup', (e) => {
	validateInput('email');
});


[resetBtn, sendBtn].forEach(btn => {
	if (btn) {
		btn.addEventListener('click', (e) => {
			e.stopPropagation();
			for (let inputName in inputs) {
				let result = validateInput(inputName);
				if (!result) {
					e.preventDefault();
				}
			}
		});
	}
});
