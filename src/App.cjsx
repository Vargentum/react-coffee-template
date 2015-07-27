### app structure:
CommentBox
  CommentList
    Comment
  CommentForm
###


###TODO: 
create CommentBox
render some markup
Render comment box
###

CommentBox = React.createClass(
  render: ->
    <div clasName="commentBox">
      Comment Box
    </div>
)


appContainer = document.getElementById('app')
React.render(<CommentBox/>, appContainer)