$ ->
  data = '<%= escape_javascript render "edit_look" %>'
  load data

  looks = '<%=
    result = ""
    @character.looks.each do |l|
      result += " #def-look-#{l.def_look.id}"
    end
    result.strip!
  %>'.split ' '

  editLookForm = '#edit-look-form'
  lookCheckBoxes = 'input[type=checkbox]'
  lookSubmitButton = '#edit-look-form .edit-character-form-submit'

  $(lookCheckBoxes).prop
    checked: false

  if looks[0]
    $(l + ' input').prop(checked: true) for l in looks

  unless $(lookCheckBoxes).is ":checked"
    startHidden lookSubmitButton


  preSubmit = ->
    if $(lookCheckBoxes).is ":checked"
      fadeOutBody ->
        $(editLookForm).submit()
        slideTo "<%= edit_character_path(@character.id) %>"


  $(lookSubmitButton).redirectButtonTo preSubmit

  $(lookCheckBoxes).redirectCheckboxTo ->
    if $(lookCheckBoxes).is ":checked"
      show lookSubmitButton
    else
      hide lookSubmitButton



  fadeInBody()
