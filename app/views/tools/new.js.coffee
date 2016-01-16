$ ->
  console.log '\nNEW TOOL'
  numTools = parseInt('<%= @character.tools.count %>')
  data = '<%= escape_javascript render "new" %>'
  tools = '<%=
    result = ""
    @character.tools.each do |t|
      result += " #def-tool-#{t.def_tool.id}"
    end
    result.strip!
  %>'.split ' '
  console.log tools

  toolList = '#tool-list'
  nameField = '#tool-name'
  descriptionField = '#tool-description'
  textFields = '#tool-text'
  defToolList = '#def-tool-list'
  done = '#tools-done'
  submitButton = '#submit-button'
  form = '#new_tool'
  editToolFormSlider = '#edit-tool-form-slider'
  editToolLink = 'a.edit_tool'
  load data
  startHidden nameField
  startHidden descriptionField
  startHidden submitButton
  startHidden editToolFormSlider
  if numTools >= 3
    startHidden form
  else
    startHidden done



  if tools[0]
    $(t + ' input').prop(checked: false, disabled: true) for t in tools

  $('input[type=text]').prop
    autocomplete: 'off'

  $('input[type=radio]').change ->
    console.log '\nCLICK TOOL'
    show nameField
    $(nameField).val ""
    $(descriptionField).val ""
    hide descriptionField
    hide submitButton
    $(nameField).focus()

  $(textFields).keyup (e) ->
    unless e.which == 13
      if $(nameField).val()
        if $(descriptionField).css('display') == 'none'
          show descriptionField
        else if $(descriptionField).val()
          show submitButton
        else
          hide submitButton
      else
        hide descriptionField
        hide submitButton

  $(editToolLink).click (e) ->
    console.log '\nCLICK EDIT TOOL'
    href = $(this).attr('href')
    hide form, ->
      fadeOut editToolFormSlider, ->
        request href
    return false

  preSubmit = ->
    console.log '\nBEFORE FORM SUBMIT'
    if $(nameField).val() && $(descriptionField).val()
      fadeOut toolList, ->
        faded = true
        $(form).submit()
      if numTools >= 2
        hide form
      hide nameField, ->
        $(nameField).val("")
      hide descriptionField, ->
        $(descriptionField).val("")
      hide submitButton
    else
      console.log 'cancel submit'
    return false

  $(descriptionField).keypress (e) ->
    if e.which == 13
      preSubmit()
      return false

  $(nameField).keypress (e) ->
    if e.which == 13
      $(descriptionField).select()
      return false

  $(submitButton).click (e) ->
    preSubmit()

  fadeInBody()
  if numTools >= 3
    $(done).focus()
  else
    $('input[type=radio]:not(:disabled):first').focus()
