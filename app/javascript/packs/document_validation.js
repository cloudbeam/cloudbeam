import { addValidationError, removeValidationError, validationTable } from './validation_module.js';

const fileName = document.querySelector('#document_name');
const uploadFile = document.querySelector('#document_upload');
const submitButton = document.querySelector('#submit_button');

const inputs = {
	fileName   : fileName,
	uploadFile : uploadFile
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

fileName.addEventListener('keyup', (e) => {
	e.preventDefault();
	validateInput('fileName');
});
uploadFile.addEventListener('blur', (e) => {
	e.preventDefault();
	validateInput('uploadFile');
});
// for (let prop in inputs) {
// 	let element = inputs[prop];
// 	element.addEventListener('blur', (e) => {
// 		e.preventDefault();
// 		validateInput(prop);
// 	});
// }

submitButton.addEventListener('click', (e) => {
	for (let inputName in inputs) {
		let result = validateInput(inputName);
		if (!result) {
			e.preventDefault();
		}
	}
});
