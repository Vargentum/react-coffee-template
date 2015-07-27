### app structure:
CommentBox
  CommentList
    Comment
  CommentForm
###


###TODO: 

###


###---------------- Comment ----------------###
Comment = React.createClass(
  render: ->
    <li>
      <h2>{this.props.author}</h2>
      {this.props.children}
    </li>
)


###---------------- CommentList ----------------###
CommentList = React.createClass(
  render: ->
    <ul clasName="commentList">
      <Comment author="John Doe">Ontrinsicly myocardinate intermandated outsourcing rather than bricks portals.</Comment>
      <Comment author="Jane Doe">Distinctively deploy diverse functionalities before just in time services.</Comment>
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