###
General
1.1. Display list of contacts(C)
1.2. Search trhough this list
1.3. View and Edit contact info
1.4. Create new contact
Groups
2.1. create Group of contacts
2.2. grouping contacts


###


###
APP Structure:
PhoneBook
  SearchForm
  ContactsList
    Contact
  CreateForm
###


###------------------- Contact ------------------------###
Contact = React.createClass(
  render: ->
    
)


###------------------- ContactList ------------------------###
ContactList = React.createClass(
  render: ->
    
)


###------------------- SearchForm ------------------------###
SearchForm = React.createClass(
  render: ->
    
)


###------------------- CreateForm ------------------------###
CreateForm = React.createClass(

  r_form: (type) ->
    switch type
      when 'contact'
        <form>
          <input type="text" ref="name" />
          <textarea ref="description" />
          <button>Save Contact</button>
        </form>
      when 'group'
        <form>
          <input type="text" ref="name" />
          <textarea ref="description" />
          <button>Save Group</button>
        </form>
      else null
    

  render: ->
    form = r_form(@type.formType)

    <div>
      {form}
    </div>
)

###------------------- PhoneBook ------------------------###
PhoneBook = React.createClass(

  getItinialState: ->
    this.state.formType = ''

  makeContact: ->
    @setState formType: 'contact'

  makeGroup: ->
    @setState formType: 'group'

  render: ->
    config = @props.config
    console.log @state

    <div>
      # <SearchForm />
      # <ContactList />
      <CreateForm type={this.state.formType} />

      <button onClick={this.makeContact}>New Contact</button>
      <button onClick={this.makeGroup}>New Group</button>
    </div>
)
