$ ->
  console.log '\nEDIT TOOL'
  data = '<%= escape_javascript render partial: "tools/edit.html.erb", locals: {tool: @tool} %>'
  numTools = parseInt('<%= @character.tools.count %>')
  newToolForm = '#new_tool'
  editToolFormSlider = '#edit-tool-form-slider'
  editToolForm = 'form.edit_tool'
  nameField = '#edit-tool-name'
  descriptionField = '#edit-tool-description'
  cancelButton = '#cancel-button'
  deleteButton = '#delete-tool-button'
  submitButton = '#edit-tool-submit-button'
  $(editToolFormSlider).html(data)

  $(cancelButton).redirectButtonTo ->
    hide editToolFormSlider, ->
      if numTools < 3
        show newToolForm

  preSubmit = ->
    console.log '\nBEFORE SUBMIT EDIT TOOL'
    if $(nameField).val() && $(descriptionField).val()
      fadeOutBody =>
        $(submitButton).submit()
      return false
    else
      console.log 'cancel submit'
      return false

  $(nameField).redirectReturnTo ->
    $(descriptionField).select()

  $(descriptionField).redirectReturnTo preSubmit
  $(submitButton).redirectButtonTo preSubmit

  $(editToolForm).keyup (e) ->
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

  $(deleteButton).redirectButtonTo (me) ->
    console.log '\nCLICK DELETE TOOL'
    href = $(me).attr('href')
    dataMethod = $(me).attr('data-method')
    fadeOutBody ->
      request href, dataMethod

  show editToolFormSlider
  $(nameField).select()
