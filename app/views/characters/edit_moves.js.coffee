$ ->
  console.log '\nEDIT MOVES'
  data = '<%= escape_javascript render "edit_moves" %>'
  moveCount = parseInt '<%= @character.move_count %>'
  submitButton = '#submit-button'
  formClickable = '.move-form-clickable'
  freeCheckbox = '.free-move-checkbox'
  checkbox = '.move-checkbox'

  load data
  if $(checkbox + ':checked').length >= moveCount
    $(checkbox + ':not(:checked)').prop
      disabled: true
  else
    startHidden submitButton

  $(freeCheckbox).change ->
    console.log '\nCHANGE FREE CHECKBOX'
    $(this).prop(checked: true)

  $(checkbox).change ->
    console.log '\nCHANGE CHECKBOX'
    console.log $('input[type=checkbox]:checked').length
    if $(checkbox + ':checked').length >= moveCount
      $(checkbox + ':not(:checked)').prop
        disabled: true
      show submitButton
    else
      $(checkbox + ':disabled').prop
        disabled: false
      hide submitButton

  $(checkbox).redirectReturnTo (me) ->
    console.log 'return'
    console.log me
    $(me).click()

  $(formClickable).click ->
    console.log '\nCLICK FORM'
    $(this).parent().find('input[type=checkbox]').click()
    return false

  $(submitButton).redirectButtonTo ->
    console.log '\nSUBMIT FORM'
    if $(checkbox + ':checked').length == moveCount
      fadeOutBody ->
        $('form').submit()
        slideQuietlyTo '<%= character_path(@character.id) %>'
    else
      console.log 'cancel submit'

  fadeInBody()
