$ ->
  console.log '\nEDIT NAME'
  data = '<%= escape_javascript render "edit_name" %>'
  load data

  editForm = '#edit-character-form'
  submitButtons = '.edit-character-form-submit'
  editSubmitButton = '#edit-character-form #submit-button'
  alternateForm = '#alternate-form-1'
  alternateSubmitButton = '#alternate-form-1 .edit-character-form-submit'
  textField = 'input[type=text]'

  if '<%= @character.name %>' == ''
    startHidden editSubmitButton
    startHidden alternateForm
    startHidden alternateSubmitButton
  else if '<%= @character.archetype.sample_names.find_by(name: @character.name) %>' == ''
    startHidden editSubmitButton
  else
    startHidden alternateForm
    startHidden alternateSubmitButton

  $('input[type=text]').prop
    autocomplete: 'off'

  $('.edit-character-form').on 'ajax:success', (e, data, status, xhr) ->
    console.log '\nFORM SUBMIT'
    slideQuietlyTo '<%= edit_character_path(@character) %>'

  preSubmit = ->
    console.log '\nFORM SUBMIT'
    if $('.sample-name').is ":checked"
      fadeOutBody ->
        $(editForm).submit()
    else if $('.name-category').is ":checked"
      console.log $(textField).val()
      unless $(textField).val() == ""
        fadeOutBody ->
          $(alternateForm).submit()

  $(submitButtons).redirectButtonTo preSubmit
  $(textField).redirectReturnTo preSubmit

  $('input[type=radio].sample-name').redirectRadioTo ->
    console.log 'click sample name'
    if $(alternateForm).css("display") == "none"
      hide editSubmitButton, ->
        show editSubmitButton
        $(editSubmitButton).children("input").focus();
    else
      hide alternateForm, ->
        show editSubmitButton
        $(editSubmitButton).children("input").focus();

  $('input[type=radio].name-category').redirectRadioTo ->
    console.log 'click name category'
    if $(alternateForm).css("display") == "none"
      hide editSubmitButton, ->
        $(textField).val("")
        show alternateForm
        $(textField).select();
        startHidden alternateSubmitButton;
    else
      hide alternateForm, ->
        startHidden alternateSubmitButton;
        $(textField).val("")
        show alternateForm
        $(textField).select();

  $(textField).keyup ->
    if $(this).val()
      show alternateSubmitButton
    else
      hide alternateSubmitButton


  fadeInBody()
