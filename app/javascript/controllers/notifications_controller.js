import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [ 'notificationBox', "parentDiv" ]

  showNotifications() {
    const parentDiv = this.parentDivTarget;
    const notificationBox = this.notificationBoxTarget.innerHTML;
    // console.log(notificationBox)
    parentDiv.insertAdjacentHTML('afterend', notificationBox);
  }
}
