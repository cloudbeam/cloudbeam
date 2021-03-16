setTimeout(() => {
  let notice = document.querySelector('.notice');
  if (notice) {
    document.querySelector('.notice').textContent = "";
  }
}, 10000);
self.selectedStyle = "border-orange text-orange border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 whitespace-nowrap pb-4 px-1 border-b-2 font-medium text-lg";
self.notSelectedStyle = "border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 whitespace-nowrap pb-4 px-1 border-b-2 font-medium text-lg"
self.activePane = null;
self.activePane = "manage";
document.querySelector("#file-navpane").addEventListener('click', e => {
  e.preventDefault();
  console.log('clicked');
  let a = e.target.closest('a');
  if (a) {
    let refId = a.dataset.ref
    if (refId == self.activePane) {
      return;
    }
    let pane = document.querySelector(`#${refId}`);
    pane.classList.remove("hidden");
    pane.classList.add("active");
    let previousActivePane = document.querySelector(`[data-ref="${self.activePane}"`);
    let currentActivePane = document.querySelector(`[data-ref="${refId}"`);
    previousActivePane.className = self.notSelectedStyle;
    currentActivePane.className = self.selectedStyle;
    

    document.querySelector(`#${self.activePane}`).classList.add("hidden");
    document.querySelector(`#${self.activePane}`).classList.remove("active");
    // document.querySelector(`[data-ref="${self.activePane}"`).class.replace(self.selectedStyle, "");
    // document.querySelector(`[data-ref="${self.activePane}"`).class += self.notSelectedStyle;
    // document.querySelector(`[data-ref="${refId}"`).class += self.selectedStyle;
    // document.querySelector(`[data-ref="${refId}"`).class.replace(self.notSelectedStyle, "");
    self.activePane = refId;
  }
});
