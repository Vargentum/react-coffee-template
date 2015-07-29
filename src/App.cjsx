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
    commentNodes = @props.data?.map((comment, i) ->
      <Comment key={i} author={comment.author}>{comment.text}</Comment>
    )

    <ul className="mdl-cell  mdl-cell--8-col">
      {commentNodes}
    </ul>
)

###---------------- CommentForm ----------------###
CommentForm = React.createClass(
  getInitialState: ->
    comment: {}

  clearInputData: ->
    @setState(
      comment.author = ''
      comment.text = ''
    )

  fetchFormData: ->
    author = React.findDOMNode(@refs.author).value.trim()
    text = React.findDOMNode(@refs.text).value.trim()

    # validate
    if not author or not text
      return

    @props.onFormSubmit(
      author: author
      text: text
    )


  render: ->
    <div className="mdl-cell  mdl-cell--4-col">
      <div className="mdl-textfield mdl-js-textfield textfield-demo">
        <input className="mdl-textfield__input" type="text" id="comment-author"
               ref="author"/>
        <label className="mdl-textfield__label" htmlFor="comment-author">Your Name</label>
      </div>
      <div className="mdl-textfield mdl-js-textfield textfield-demo">
        <textarea className="mdl-textfield__input" type="text" id="comment-text" 
                  ref="text"/>
        <label className="mdl-textfield__label" htmlFor="comment-text">Your commentary</label>
      </div>
      
      <button className="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent"
              onClick={this.fetchFormData}>
        Post feedback
      </button>

      <p>{this.state.status}</p>
    </div>
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

  postComment: (comment) ->
    # optimistic update (before the)
    comments = @state.data
    updatedComments = comments.concat(comment)
    @setState data: updatedComments

    console.log JSON.stringify(comment)
    $.ajax(
      url: @props.url
      method: 'POST'
      dataType: 'json'
      contentType: "application/json"
      processData: off
      data: JSON.stringify(comment)
      success: ((data) ->
        @setState data: data
        console.log 'posted "#{comment.text}" as #{comment.author}'
      ).bind(this)

      error: ((xhr, status, err) ->
        @setState(
          status: 'Request failed in reason of #{err}. Status is #{status}'
        )
      ).bind(this)
    )


  getInitialState: ->
    data: []

  componentDidMount: ->
    ###Try to use WebSockets here###
    this.fetchDataFromServer()
    setInterval(@fetchDataFromServer, @props.pollInterval)

  render: ->
    <div>
      <h1>Comments</h1>
      <div className="mdl-grid">
        <CommentList data={this.state.data}/>
        <CommentForm onFormSubmit={this.postComment}/>
      </div>
    </div>
)


appContainer = document.getElementById('app')
React.render(<CommentBox url="public/comments.json" pollInterval={5000}/>, appContainer)