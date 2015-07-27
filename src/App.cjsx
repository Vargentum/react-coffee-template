### app structure:
CommentBox
  CommentList
    Comment
  CommentForm
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
    commentData = @props.data.comments
    commentNodes = commentData?.map((comment, i) ->
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
  fetchDataFromServer: ->
    $.ajax(
      url: @props.url
      dataType: 'json'
      cache: off
      success: ((data) ->
        @setState(data: data)
      ).bind(this)

      error: ((xhr, status, err) ->
        console.error @props.url, status, err.toString()
      ).bind(this)
    )

  getInitialState: ->
    data: []

  componentDidMount: ->
    ###Try to use WebSockets here###
    setInterval(@fetchDataFromServer, @props.pollInterval)

  render: ->
    <div clasName="commentBox">
      <h1>Comments</h1>
      <CommentList data={this.state.data}/>
      <CommentForm />
    </div>
)


appContainer = document.getElementById('app')
React.render(<CommentBox url="public/comments.json" pollInterval={5000}/>, appContainer)