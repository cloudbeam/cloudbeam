addEventListener('direct-upload:initialize', (event) => {
	console.log('direct upload initialized');

	const { target, detail } = event;
	const { id, file } = detail;
	const fileName = document.querySelector('#document_name').value;
	target.insertAdjacentHTML(
		'beforebegin',
		`
		<div id="direct-upload-${id}" class="direct-upload direct-upload--pending">
			<div id="direct-upload-progress-${id}" class="direct-upload__progress" style="width: 0%"></div>
			<span class="direct-upload__filename"></span>
		</div>
  `
	);
	target.previousElementSibling.querySelector(`.direct-upload__filename`).textContent = fileName;
});

addEventListener('direct-upload:start', (event) => {
	console.log('direct upload started');
	const { id } = event.detail;
	const element = document.getElementById(`direct-upload-${id}`);
	element.classList.remove('direct-upload--pending');
});

addEventListener('direct-upload:progress', (event) => {
	console.log('direct upload progress event');
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
