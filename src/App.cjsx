### app structure:
CommentBox
  CommentList
    Comment
  CommentForm
###


###TODO: 
create CommentList and CommentForm
render them inside CommentBox
###


###---------------- CommentList ----------------###
CommentList = React.createClass(
  render: ->
    <ul clasName="commentList">

    </ul>
)

###---------------- CommentForm ----------------###
CommentForm = React.createClass(
  render: ->
    <form>
      <textarea name="newComment" placeholder="Leave a feedback..." />
      <button onClick={}>Post</button>
    </form>
)


###---------------- CommentBox ----------------###
CommentBox = React.createClass(
  render: ->
    <div clasName="commentBox">
      <h1>Comments</h1>
      <CommentList />
      <CommentForm />
    </div>
)


appContainer = document.getElementById('app')
React.render(<CommentBox/>, appContainer)