import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [ 'notificationBox', "parentDiv", 'notificationTemplate', 'notificationBtn' ]

  connect() {
    this.outsideClickHandler = this.closeNotifications.bind(this);
  }

  openNotifications() {
    if (this.hasNotificationBoxTarget && this.notificationBoxTarget.classList.contains("hidden")) { //If notification box was hidden before
      this.notificationBoxTarget.classList.remove("hidden");
      this.changeBtnAction();
    }
    else {
      this.showNotifications();
      this.changeBtnAction();
    }
    this.addOutsideClickListener();
  }

  addOutsideClickListener() {
    // We are using timeout func in order to avoid notification box being immediately hidden upon clicking bell icon.
    setTimeout(() => document.addEventListener("click", this.outsideClickHandler), 100);
  }

  changeBtnAction(){
    const btn = this.notificationBtnTarget;
    const action = btn.getAttribute("data-action");
    btn.removeAttribute("data-action");
    if (action == "notifications#openNotifications"){
      btn.setAttribute("data-action", "notifications#closeNotifications")
    }
    else {
      btn.setAttribute("data-action", "notifications#openNotifications")
    }
  }

  showNotifications() {
    const parentDiv = this.parentDivTarget;
    const notificationBox = this.notificationTemplateTarget.innerHTML;
    parentDiv.insertAdjacentHTML('beforeEnd', notificationBox);
  }

  closeNotifications(e) {
    //If e.target is not the notification box AND notification box doesn't contain e.target(to make
    // sure user can interact with notifications inside the box).
    if(e.target !== this.notificationBoxTarget && !this.notificationBoxTarget.contains(e.target)){
      this.notificationBoxTarget.classList.add("hidden");
      this.changeBtnAction();
      this.removeOutsideClickListener();
    }
  }

  removeOutsideClickListener() {
    document.removeEventListener("click", this.outsideClickHandler);
  }

}
