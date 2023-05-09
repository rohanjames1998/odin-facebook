import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [ 'friendReqBtn' ]

  changeBtn(e){
    setTimeout(() =>{
      this.friendReqBtnTargets.forEach((btn) => {
        if (btn != e.target){
          btn.classList.remove("hidden");
          btn.disabled = false;
        }
      })}, 500);

    setTimeout(() => {
      e.target.disabled = true;
      e.target.classList.add("hidden");
    }, 500)
  }
}
