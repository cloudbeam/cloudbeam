import { addValidationError, removeValidationError, validationTable } from './validation_module.js';

document.querySelector('#clear').addEventListener('click', (e) => {
	e.preventDefault();
	let response = confirm("Are you sure you want to clear the entire form?");
	if (response == true) {
		document.querySelector('#message').value = '';
		document.querySelector('#recipients').value = '';
	}
});

const emailList = document.querySelector('#email-list');
const submitButton = document.querySelector('#submit_button');

const inputs = {
	emailList : emailList
};

function validateInput(inputName) {
	let inputElement = inputs[inputName];
	let inputValue = inputElement ? inputElement.value : '';
	let result = validationTable[inputName](inputValue);
	if (inputElement) removeValidationError(inputElement);
	if (result !== true && inputElement) {
		addValidationError(inputElement, result);
		return false;
	} else {
		return true;
	}
}

for (let prop in inputs) {
	let element = inputs[prop];
	if (!element) continue;
	element.addEventListener('keyup', (e) => {
		e.preventDefault();
		validateInput(prop);
	});
}

submitButton.addEventListener('click', (e) => {
	for (let inputName in inputs) {
		let result = validateInput(inputName);
		if (!result) {
			e.preventDefault();
		}
	}
});
