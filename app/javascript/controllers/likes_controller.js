import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [ 'likeBtn', 'likeCounter']


  changeCount(e){
    const indicatorText = this.likeCounterTarget.textContent
    console.log("hello")
    if (indicatorText == ""){
      this.likeCounterTarget.textContent = "1 Like"
    }
    else if (indicatorText == "1 Like"){
      this.likeCounterTarget.textContent = "2 Likes"
    }
    else {
      // Increasing the likes count
      let likesCount = parseInt(indicatorText.split(" ")[0])
      console.log(likesCount)
      this.likeCounterTarget.textContent = `${likesCount += 1} Likes`
    }
  }
}
