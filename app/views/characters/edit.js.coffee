$ ->
  console.log '\nEDIT CHARACTER'
  data = '<%=
    case params[:field]
    when "name"
      escape_javascript render "edit_name"
    when "look"
      escape_javascript render "edit_look"
    end  %>'
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
    console.log '\nFORM SUBMIT'
    slideQuietlyTo data

  preSubmit = ->
    console.log '\nFORM SUBMIT'
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
    console.log 'click sample name'
    hide alternateForm, ->
      show editSubmitButton

  $('input[type=radio].name-category').redirectRadioTo ->
    console.log 'click name category'
    hide editSubmitButton, ->
      show alternateForm
      unless $(textField).val() == ""
        show alternateSubmitButton

  $(lookCheckBoxes).redirectCheckboxTo ->
    console.log 'click look'
    if $(lookCheckBoxes).is ":checked"
      show lookSubmitButton
    else
      hide lookSubmitButton

  $(textField).keyup ->
    if $(this).val()
      show alternateSubmitButton
    else
      hide alternateSubmitButton

  fadeInBody()
