import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
    static targets = [ 'streamElement', 'dialogCont' ]

    startStream() {
			const streamCont = document.createElement('div')
			streamCont.setAttribute('id', 'stream-cont')

			const liveStreamHTML = this.streamElementTarget.innerHTML

			streamCont.innerHTML = liveStreamHTML;

			this.dialogContTarget.appendChild(streamCont);
    }

		endStream() {
			const streamCont = document.getElementById('stream-cont');

			streamCont.remove();
		}

}
