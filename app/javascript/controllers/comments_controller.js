import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [ 'dialogBox', "commentsCont", "commentText", "replyForm", "replyBtn" ]

  openDialog() {
    this.dialogBoxTarget.showModal();
  }

  closeDialog() {
    this.dialogBoxTarget.close();
  }

  showReplyForm(e){
    const parentId = e.params.parentId;
    const parentDiv = document.querySelector(`#comment_${parentId}`);
    const replyForm = this.replyFormTarget.innerHTML;
    parentDiv.insertAdjacentHTML('beforeend', replyForm );
  }


}
