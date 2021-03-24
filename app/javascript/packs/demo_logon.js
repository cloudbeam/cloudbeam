const demoBtn = document.querySelector('#demo-logon');


demoBtn.addEventListener('click', function(e) {
  e.preventDefault();
  logonDemoUser();
});


function logonDemoUser() {
  let email  = 'demo@cloud-beam.com';
  let password = 'cloudbeam-demo';

  const emailInput = document.querySelector('#user_email');
  const passwordInput = document.querySelector('#user_password');
  const loginBtn = document.querySelector('#login-btn');

  emailInput.value = email;
  passwordInput.value = password;
  loginBtn.click();
}
