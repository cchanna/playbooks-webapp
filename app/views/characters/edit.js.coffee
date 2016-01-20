$ ->
  console.log 'edit character'
  data = '<%=
    case params[:field]
    when "name"
      escape_javascript render "edit_name"
    end  %>'
  load data

  editForm = '#edit-character-form'
  submitButton = '#edit-character-form .edit-character-form-submit'
  startHidden submitButton
  alternateForm = '#alternate-form-1'
  startHidden alternateForm
  alternateSubmitButton = '#alternate-form-1 .edit-character-form-submit'
  startHidden alternateSubmitButton
  textField = 'input[type=text]'

  $('input[type=text]').prop
    autocomplete: 'off'

  unless '<%= @character.name %>' == ''
    if '<%= @character.archetype.sample_names.find_by(name: @character.name) %>' == ''
      show alternateForm
      show alternateSubmitButton
    else
      show submitButton

  $(submitButton).redirectButtonTo ->
    if ('.sample-name').is ":checked"
      fadeOutBody ->
        $(editForm).submit()

  $('.edit-character-form').on 'ajax:success', (e, data, status, xhr) ->
    console.log '\nFORM SUBMIT'
    slideQuietlyTo data

  preSubmit = ->
    console.log '\nFORM SUBMIT'
    if $('.name-category').is ":checked"
      fadeOutBody ->
        $(alternateForm).submit()

  $(alternateSubmitButton).redirectButtonTo preSubmit
  $(textField).redirectReturnTo preSubmit

  $('input[type=radio].sample-name').redirectRadioTo ->
    console.log 'click sample name'
    hide alternateForm, ->
      show submitButton

  $('input[type=radio].name-category').redirectRadioTo ->
    console.log 'click name category'
    hide submitButton, ->
      show alternateForm
      unless $(textField).val() == ""
        show alternateSubmitButton

  $(textField).keyup ->
    if $(this).val()
      show alternateSubmitButton
    else
      hide alternateSubmitButton

  fadeInBody()
