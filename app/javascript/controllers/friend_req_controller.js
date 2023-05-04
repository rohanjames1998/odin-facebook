import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [ 'friendReqBtn' ]

  changeBtn(e){
    this.friendReqBtnTargets.forEach((btn) => {
      if (btn != e.target){
        console.log(btn)
        btn.classList.remove("hidden");
        btn.disabled = false;
      }
    })
    e.target.disabled = true;
    e.target.classList.add("hidden");
  }
}
