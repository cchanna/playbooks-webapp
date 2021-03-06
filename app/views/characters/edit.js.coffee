$ ->
  data = '<%= escape_javascript render "edit" %>'
  load data

  looks = '<%=
    result = ""
    @character.looks.each do |l|
      result += " #def-look-#{l.def_look.id}"
    end
    result.strip!
  %>'.split ' '

  editForm = '#edit-character-form'
  editLookForm = '#edit-look-form'
  submitButtons = '.edit-character-form-submit'
  editSubmitButton = '#edit-character-form .edit-character-form-submit'
  startHidden editSubmitButton
  alternateForm = '#alternate-form-1'
  startHidden alternateForm
  alternateSubmitButton = '#alternate-form-1 .edit-character-form-submit'
  startHidden alternateSubmitButton
  lookSubmitButton = '#edit-look-form .edit-character-form-submit'
  textField = 'input[type=text]'
  lookCheckBoxes = 'input[type=checkbox]'
  editLinks = '#edit-links'

  addImprovement = '.add-improvement'

  $(lookCheckBoxes).prop
    checked: false

  if looks[0]
    $(l + ' input').prop(checked: true) for l in looks

  unless $(lookCheckBoxes).is ":checked"
    startHidden lookSubmitButton


  $('input[type=text]').prop
    autocomplete: 'off'

  unless '<%= @character.name %>' == ''
    if '<%= @character.archetype.sample_names.find_by(name: @character.name) %>' == ''
      show alternateForm
      show alternateSubmitButton
    else
      show editSubmitButton

  $('.edit-character-form').on 'ajax:success', (e, data, status, xhr) ->
    slideQuietlyTo data

  preSubmit = ->
    if $('.sample-name').is ":checked"
      fadeOutBody ->
        $(editForm).submit()
    else if $('.name-category').is ":checked"
      fadeOutBody ->
        $(alternateForm).submit()
    else if $(lookCheckBoxes).is ":checked"
      fadeOutBody ->
        $(editLookForm).submit()

  $(submitButtons).redirectButtonTo preSubmit
  $(textField).redirectReturnTo preSubmit

  $('input[type=radio].sample-name').redirectRadioTo ->
    hide alternateForm, ->
      show editSubmitButton

  $('input[type=radio].name-category').redirectRadioTo ->
    hide editSubmitButton, ->
      show alternateForm
      unless $(textField).val() == ""
        show alternateSubmitButton

  $(lookCheckBoxes).redirectCheckboxTo ->
    if $(lookCheckBoxes).is ":checked"
      show lookSubmitButton
    else
      hide lookSubmitButton

  $(textField).keyup ->
    if $(this).val()
      show alternateSubmitButton
    else
      hide alternateSubmitButton

  $(addImprovement).on 'ajax:success', (e, data, status, xhr) ->
    improvement =  $(editLinks).append(data).children().last()
    growIn improvement
    
  fadeInBody()
