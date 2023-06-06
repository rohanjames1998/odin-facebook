import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [ 'dialogBox', "commentsCont", "commentText" ]

  openDialog() {
    this.dialogBoxTarget.showModal();
  }

  prependComment() {
    const comment = ` <div> ${this.commentTextTarget.value} </div>`

    this.commentsContTarget.insertAdjacentHTML("afterbegin", comment);
  }

}
