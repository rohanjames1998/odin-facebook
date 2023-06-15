import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [ 'dialogBox' ]

  openDialog() {
    this.dialogBoxTarget.showModal();
  }

  closeDialog() {
    this.dialogBoxTarget.close();
  }
}
