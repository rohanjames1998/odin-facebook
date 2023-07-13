import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [ 'notificationBox', "parentDiv", 'notificationTemplate' ]

  connect() {
    this.outsideClickHandler = this.closeNotifications.bind(this);
  }

  openNotifications() {
    if (this.hasNotificationBoxTarget) { //If notification box was hidden before
      this.notificationBoxTarget.classList.remove("hidden");
    }
    else {
      this.showNotifications();
    }
    // We are using timeout func in order to avoid notification box being immediately hidden upon clicking bell icon.
    setTimeout(() => document.addEventListener("click", this.outsideClickHandler), 100);
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
      document.removeEventListener("click", this.outsideClickHandler);
    }
  }

}
