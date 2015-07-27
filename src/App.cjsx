### app structure:
CommentBox
  CommentList
    Comment
  CommentForm
###


###TODO: 
write array with json-like data
pass data to CL
map Ct with data
###


data = [
  {author: 'John Doe', text: 'Ontrinsicly myocardinate intermandated outsourcing rather than bricks portals.'}
  {author: 'Jane Doe', text: 'Distinctively deploy *diverse functionalities* before just in time services.'}
  {author: 'Ann Kelly', text: 'ntrinsicly negotiate exceptional synergy after wireless e-commerce.'}
]


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
    commentNodes = @props.comments.map((comment, i) ->
      <Comment key={i} author={comment.author}>{comment.text}</Comment>
    )
    
    <ul>
      {commentNodes}
    </ul>
)

###---------------- CommentForm ----------------###
CommentForm = React.createClass(
  render: ->
    <form>
      <textarea name="newComment" placeholder="Leave a feedback..." />
      <button>Post</button>
    </form>
)


###---------------- CommentBox ----------------###
CommentBox = React.createClass(
  render: ->
    <div clasName="commentBox">
      <h1>Comments</h1>
      <CommentList comments={this.props.data}/>
      <CommentForm />
    </div>
)


appContainer = document.getElementById('app')
React.render(<CommentBox data={data}/>, appContainer)