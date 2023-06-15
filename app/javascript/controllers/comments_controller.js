import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ["commentsCont", "commentText", "replyForm", "replyBtn" ]



  showReplyForm(e){
    const parentId = e.params.parentId;
    const parentDiv = document.querySelector(`#comment_${parentId}`);
    const replyForm = this.replyFormTarget.innerHTML;
    parentDiv.insertAdjacentHTML('beforeend', replyForm );
  }


}
