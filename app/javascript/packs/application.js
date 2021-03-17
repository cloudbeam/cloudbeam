// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require('@rails/ujs').start();
require('turbolinks').start();
require('@rails/activestorage').start();
require('channels');
require('alpinejs');

import { inputChangeSelector } from '@rails/ujs';
import { ignoreFocusedForValueBinding } from 'alpinejs';
import 'stylesheets/application';

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// Active Storage
//= require activestorage

// direct_uploads.js
addEventListener('direct-upload:initialize', (event) => {
	const { target, detail } = event;
	const { id, file } = detail;
	target.insertAdjacentHTML(
		'beforebegin',
		`
    <div id="direct-upload-${id}" class="direct-upload direct-upload--pending">
      <div id="direct-upload-progress-${id}" class="direct-upload__progress" style="width: 0%"></div>
      <span class="direct-upload__filename"></span>
    </div>
  `
	);
	target.previousElementSibling.querySelector(`.direct-upload__filename`).textContent = file.name;
});

addEventListener('direct-upload:start', (event) => {
	const { id } = event.detail;
	const element = document.getElementById(`direct-upload-${id}`);
	element.classList.remove('direct-upload--pending');
});

addEventListener('direct-upload:progress', (event) => {
	const { id, progress } = event.detail;
	const progressElement = document.getElementById(`direct-upload-progress-${id}`);
	progressElement.style.width = `${progress}%`;
});

addEventListener('direct-upload:error', (event) => {
	event.preventDefault();
	const { id, error } = event.detail;
	const element = document.getElementById(`direct-upload-${id}`);
	element.classList.add('direct-upload--error');
	element.setAttribute('title', error);
});

addEventListener('direct-upload:end', (event) => {
	const { id } = event.detail;
	const element = document.getElementById(`direct-upload-${id}`);
	element.classList.add('direct-upload--complete');
});

// Document validation - needs to be packed
// we need to listen for an input field losing focus
// when it loses focus check if the input is valid
// if it is not valid,
//   -modify the dom to show validation error
//   -add class of 'invalid' to classList

// listen for submit click
//   scan DOM for any element with class of 'invalid'
//   if present
//     prevent submission
//     add message to fix errors
//   if not present
//     submit

// on document
//   listen for lose focus
//   if target is input field
//     if target id is 'document_name'
//       if valid_document_name(target)
//         clear_validation_error(target)
//         do nothing
//       else
//         show_validation_error(target)
//       end
//     end
//   end

// valid_document_name(input_element)
//   set name = input_element's value
//   if name is not blank AND name matches /\A[\d|\w]+[\d|\w|.| ]+[\d|\w]+\z/i
//     AND name length is between 3 and 30
//     return true
//   else
//     return false
//   end
//   end

// show_validation_error(input_element)
//   add tailwinds css class to element
//     text-red-600
//     border-red-600
//   remove tailwinds css class
//     border-navy
//   add specific message for error
//     create a new element on the dom
//     set styles and content
//       inner text VALIDATION_ERROR[:file_name]
//       class list => 'invalid flex-1 block w-full min-w-0 rounded-md sm:text-sm border-red-900'
//     insert after input element

// remove_validation_error(input_element)
//   remove tailwinds css class from element
//     text-red-600
//     border-red-600
//   add tailwinds css class
//     border-navy
//   find subsequent validation error
//     remove next element sibling

// any_invalid_inputs?
//   document.querySelectorAll('.invalid').length > 0

// present_submission_error(submit_button)
//   alert ('please fix all errors before submitting!')
// check to make sure all input fields are not blank
// save collection of inputs
// if any blank present
// 	preventDefault
// 	focusin on each element then focus out
// 	pop up alert
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

const VALIDATION_ERRORS = {
	fileName   :
		"File names need to be at least 3 characters long, START and END with a letter or number, and only contain letters, numbers, '.' and spaces!",
	fileUpload : 'Please select a file to beam up to our cloud!'
};

function validFileName(inputElement) {
	let fileName = inputElement.value;
	let fileRegEx = new RegExp(/^[\d|\w]+[\d|\w|.| ]+[\d|\w]+$/);
	return fileName.length >= 3 && fileRegEx.test(fileName);
}
function uploadNotEmpty(inputElement) {
	return inputElement.value.length > 0;
}

function addValidationError(inputElement, validationErrorType) {
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
		warningDialogue.innerText = VALIDATION_ERRORS[validationErrorType];
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
	console.log('Input is back to normal');
}

document.addEventListener('DOMContentLoaded', (event) => {
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
				addValidationError(fileNameInput, 'fileName');
			}
		} else if (e.target === fileUploadInput) {
			if (uploadNotEmpty(fileUploadInput)) {
				removeValidationError(fileUploadInput);
			} else {
				addValidationError(fileUploadInput, 'fileUpload');
			}
		}
	});

	submit.addEventListener('click', (e) => {
		e.preventDefault();
		const targetInputs = [ fileNameInput, fileUploadInput ];
		toggleInputs(targetInputs);
		if (invalidInputsPresent()) {
			alert('Please fix your information and we can continue.');
		} else {
			console.log(form);
			form.submit();
		}
	});
});
