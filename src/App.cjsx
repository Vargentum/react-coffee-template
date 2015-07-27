### app structure:
CommentBox
  CommentList
    Comment
  CommentForm
###


###TODO: 
convert comment body to string then convert with marked to html
sanitize this html with marked
than insert with dangerouslyInsert
###


###---------------- Comment ----------------###
Comment = React.createClass(
  render: ->
    rawMarkup = marked(@props.children.toString(),
      sanitize: on
    )
    <li>
      <h2>{this.props.author}</h2>
      {<div dangerouslySetInnerHTML={__html: rawMarkup} />}
    </li>
)


###---------------- CommentList ----------------###
CommentList = React.createClass(
  render: ->
    <ul clasName="commentList">
      <Comment author="John Doe">Ontrinsicly myocardinate intermandated outsourcing rather than bricks portals.</Comment>
      <Comment author="Jane Doe">Distinctively deploy *diverse functionalities* before just in time services.</Comment>
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