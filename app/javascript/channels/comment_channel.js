import consumer from "./consumer"

if (location.pathname.match(/\/items\/\d/)) {

consumer.subscriptions.create({
  channel: "CommentChannel",
  item_id: location.pathname.match(/\d+/)[0]
  }, {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const html = `
    <div class="comment">
      <p class="user-info">${data.user.nickname}: ${data.comment.text} </p>
    </div>`
    const comment = document.getElementById("comments-index")
    comment.insertAdjacentHTML('beforeend', html)
    const commentForm = document.getElementById("comment-form")
    commentForm.reset();
  }
});
}