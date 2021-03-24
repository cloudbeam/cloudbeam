import { addValidationError, removeValidationError, validationTable } from './validation_module.js';

document.querySelector('#clear').addEventListener('click', (e) => {
	e.preventDefault();
	document.querySelector('#message').value = '';
});

const emailList = document.querySelector('#recipients');
const submitButton = document.querySelector('#submit_button');

const inputs = {
	emailList : emailList
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
	let element = inputs[prop];
	if (!element) continue; 
	element.addEventListener('blur', (e) => {
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
