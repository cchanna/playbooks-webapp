$ ->
  numTools = parseInt('<%= @character.tools.count %>')
  data = '<%= escape_javascript render "new" %>'
  tools = '<%=
    result = ""
    @character.tools.each do |t|
      result += " #def-tool-#{t.def_tool.id}"
    end
    result.strip!
  %>'.split ' '

  toolList = '#tool-list'
  nameField = '#tool-name'
  descriptionField = '#tool-description'
  textFields = '#tool-text'
  defToolList = '#def-tool-list'
  textArea = 'textarea'
  done = '#tools-done'
  submitButton = '#submit-button'
  form = '#new_tool'
  editToolLink = 'a.edit_tool'
  load data
  unless $(nameField).val()
    startHidden descriptionField
    startHidden submitButton

  if $("input[type=radio]").is(':checked')
    startHidden nameField
    if numTools >= 3
      startHidden form
    else
      startHidden done

  if tools[0]
    $(t + ' input').prop(checked: false, disabled: true) for t in tools

  $('input[type=text]').prop
    autocomplete: 'off'

  $("textarea").autoResize()

  $('input[type=radio]').redirectRadioTo (me) ->
    hide descriptionField, ->
      $(descriptionField).val ""
    hide submitButton
    if $(me).prop("checked")
      if $(nameField).css('display') == 'none'
        show nameField
        $(nameField).focus()
      else
        hide nameField, ->
          $(nameField).val ""
          show nameField
    else
      hide nameField

  $(textFields).keyup (e) ->
    unless e.which == 13
      if $(nameField).val()
        show descriptionField
        show submitButton
      else
        hide descriptionField
        hide submitButton

  $(editToolLink).redirectButtonTo (me) ->
    href = $(me).attr('href')
    hide form, ->
      fadeOut editToolFormSlider, ->
        request href

  preSubmit = ->
    if $("input[type=radio]").is(':checked') && $(nameField).val()
      fadeOut toolList, ->
        faded = true
        numTools++
        $(form).submit()
      if numTools >= 2
        hide form
      hide nameField, ->
        $(nameField).val("")
      hide descriptionField, ->
        $(descriptionField).val("")
      hide submitButton
    else

  $(nameField).redirectReturnTo ->
    $(descriptionField).select()

  $(descriptionField).redirectReturnTo preSubmit
  $(submitButton).redirectButtonTo preSubmit

  fadeInBody()
  if numTools >= 3
    $(done).focus()
  else
    $('input[type=radio]:not(:disabled):first').focus()
