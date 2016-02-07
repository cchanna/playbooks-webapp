$ ->
  console.log '\nEDIT TOOL'
  data = '<%= escape_javascript render partial: "tools/edit.html.erb", locals: {tool: @tool} %>'
  load data
  fadeInBody()
  nameField = '#tool-name'
  descriptionField = '#tool-description'
  textFields = '#tool-text'
  submitButton = '#submit-button'
  form = 'form'
  examples = '.tool-example'

  unless $(nameField).val()
    startHidden descriptionField
    startHidden submitButton
    unless $("input[type=radio]").is(':checked')
      startHidden nameField

  $('input[type=text]').prop
    autocomplete: 'off'

  $('input[type=radio]').redirectRadioTo (me) ->
    console.log '\nCLICK TOOL'
    hide descriptionField, ->
      $(descriptionField).val ""
    hide submitButton
    if $(me).prop("checked")
      if $(nameField).css('display') == 'none'
        $(nameField).val("")
        show nameField
        $(nameField).focus()
      else
        hide nameField, ->
          $(nameField).val ""
          show nameField
    else
      hide nameField

  $('input[type=text]').keyup (e) ->
    unless e.which == 13
      if $(nameField).val()
        show descriptionField
        show submitButton
      else
        hide descriptionField
        hide submitButton

  $("textarea").keyup ->
    console.log this.scrollHeight
    $(this).height(0);
    $(this).height(this.scrollHeight);

  $(form).on 'ajax:success', (e) ->
    slideTo '<%=edit_character_path(@character)%>'

  preSubmit = ->
    console.log '\nBEFORE FORM SUBMIT'
    if $("input[type=radio]").is(':checked') && $(nameField).val()
      fadeOutBody ->
        $(form).submit()
    else
      console.log 'cancel submit'
  $(examples).click ->
    $(this).parent().find('input[type=radio]').click()


  $(nameField).redirectReturnTo ->
    $(descriptionField).select()
  $(submitButton).redirectButtonTo preSubmit
