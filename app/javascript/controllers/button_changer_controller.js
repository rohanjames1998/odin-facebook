import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [ 'btn' ]

  changeBtn(e){
    setTimeout(() =>{
      this.btnTargets.forEach((btn) => {
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
