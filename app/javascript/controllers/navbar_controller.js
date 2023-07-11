import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [ 'icon' ]

  connect() {
  }

  highlight(e){
    e.target.classList.add("text-dark-sky-blue", "border-b-4", "border-dark-sky-blue");
    this.remove_highlight_from_others(e.target);
  }

  remove_highlight_from_others(target){
    this.iconTargets.forEach((icon) => {
      if (icon == target){
        return;
      }
      icon.classList.remove("text-dark-sky-blue", "border-b-4", "border-dark-sky-blue");
    })
  }


}
