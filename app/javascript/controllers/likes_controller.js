import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [ 'likeBtn', 'likeCounter']


  increaseCount(){
    const indicatorText = this.likeCounterTarget.textContent
    if (indicatorText == ""){
      this.likeCounterTarget.textContent = "1 Like";
    }
    else if (indicatorText == "1 Like"){
      this.likeCounterTarget.textContent = "2 Likes";
    }
    else {
      // Increasing the likes count
      let likesCount = parseInt(indicatorText.split(" ")[0]);
      this.likeCounterTarget.textContent = `${likesCount += 1} Likes`;
    }
  }

  decreaseCount(){
    const indicatorText = this.likeCounterTarget.textContent
    if (indicatorText == ""){
      return;
    }
    else if (indicatorText == "1 Like"){
      this.likeCounterTarget.textContent = "";
    }
    else {
            // Decreasing the likes count
            let likesCount = parseInt(indicatorText.split(" ")[0]);
            this.likeCounterTarget.textContent = `${likesCount -= 1} Likes`;
    }
  }
}
