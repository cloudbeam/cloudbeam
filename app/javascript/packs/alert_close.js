// alert click out functionality
function isCloseAlertElement(element) {
	return element.id == 'close_alert_btn' || element.id == 'close_alert_svg' || element.id == 'close_alert_path';
}

document.addEventListener('click', (e) => {
	if (isCloseAlertElement(e.target)) {
		const alert = document.querySelector('#alert_box');
		alert.remove();
	}
});
