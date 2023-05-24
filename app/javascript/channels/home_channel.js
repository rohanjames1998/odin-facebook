import consumer from "channels/consumer"

consumer.subscriptions.create( { channel:"HomeChannel", room: getCookie("user_id")  }, {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const postDisplay = document.querySelector("#posts")
    postDisplay.insertAdjacentHTML("beforebegin", this.template(data));
  },

  template(data) {
    return `<div>
              <p>${data.user.first_name}<p>
            </div>
            <div>
            <p>${data.text_content}<p>
            </div>`
  }
});

function getCookie(cname) {
  let name = cname + "=";
  let decodedCookie = decodeURIComponent(document.cookie);
  let ca = decodedCookie.split(';');
  for(let i = 0; i <ca.length; i++) {
    let c = ca[i];
    while (c.charAt(0) == ' ') {
      c = c.substring(1);
    }
    if (c.indexOf(name) == 0) {
      return c.substring(name.length, c.length);
    }
  }
  return "";
}
