import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [ 'btn', 'parentDiv' ]



  hideNotification() {
    setTimeout(() => {this.disableBtns()}, 500);
    this.parentDivTarget.classList.add("invisible");
  }

  disableBtns(){
    this.btnTargets.forEach((btn) => {
      btn.disabled = true;
    })
  }
}
