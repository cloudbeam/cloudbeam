setTimeout(() => {
  let notice = document.querySelector('.notice');
  if (notice) {
    document.querySelector('.notice').textContent = "";
  }
}, 10000);
const selectedStyle = "border-orange text-orange border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 whitespace-nowrap pb-4 px-1 border-b-2 font-medium text-lg";
const notSelectedStyle = "border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 whitespace-nowrap pb-4 px-1 border-b-2 font-medium text-lg"

let activePaneCategory = "manage";

function changeActivePane(newActivePaneCategory) {
  if (newActivePaneCategory == activePaneCategory) {
    return;
  }
  let previousActivePane = document.querySelector(`#${activePaneCategory}`);
  let newActivePane = document.querySelector(`#${newActivePaneCategory}`);
  previousActivePane.classList.add("hidden");
  previousActivePane.classList.remove("active");
  newActivePane.classList.remove("hidden");
  newActivePane.classList.add("active");
  let previousActiveTab = document.querySelector(`[data-ref="${activePaneCategory}"`);
  let currentActiveTab = document.querySelector(`[data-ref="${newActivePaneCategory}"`);
  previousActiveTab.className = notSelectedStyle;
  currentActiveTab.className = selectedStyle;
  activePaneCategory = newActivePaneCategory;
}

document.querySelector("#file-navpane").addEventListener('click', e => {
  e.preventDefault();
  console.log('clicked');
  let a = e.target.closest('a');
  if (a) {
    let newActivePaneCategory = a.dataset.ref;
    changeActivePane(newActivePaneCategory);
  }
});

document.querySelector("#selected-tab").addEventListener('change', e => {
  e.preventDefault();
  let newActivePaneCategory = e.target.value;
  changeActivePane(newActivePaneCategory);
});
