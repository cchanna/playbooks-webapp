$ ->
  data = '<%= escape_javascript render "edit" %>'
  load data

  form = "form"
  submit = ".submit"
  radio = 'input[type=radio]'
  body = '.body'
  option = '.option'
  optionBox = option + ' input'
  optionBoxChecked = optionBox + ':checked'
  optionBoxUnChecked = optionBox + ':not(:checked)'
  description = 'textarea'
  field = '.field input'
  move = '.move'

  getUncheckedMoves = ->
    return $(radio + ':not(:checked)').closest(move)

  unchecked = getUncheckedMoves()
  unchecked.find(optionBox).prop
    disabled: true
  unchecked.find(description).prop
    disabled: true
  unchecked.find(field).prop
    disabled: true



  $('input[type=text]').prop
    autocomplete: 'off'



  if $(radio).is(":checked")
    currentMove =  $(radio + ":checked").closest(move)
    unless currentMove.find(optionBoxChecked).length == currentMove.data("options")
      startHidden submit
  else
    startHidden submit


  $(submit).redirectButtonTo ->
    fadeOutBody ->
      $(form).submit()


  $(description).keyup ->
    $(this).height(0);
    $(this).height(this.scrollHeight);


  $(radio).change ->
    thisMove = $(this).closest(move)
    $(optionBox).prop
      disabled: true
      checked: false
    $(description).prop disabled: true
    $(description).val ""
    $(field).prop disabled: true
    $(field).val ""
    thisMove.find(optionBox).prop disabled: false
    thisMove.find(description).prop disabled: false
    thisMove.find(field).prop disabled: false
    if thisMove.data("options") == 0
      show submit
    else
      hide submit

  $(optionBox).change ->
    parent = $(this).closest(move)
    if parent.find(optionBoxChecked).length >= parent.data("options")
      parent.find(optionBoxUnChecked).prop
        disabled: true
      show submit
    else
      parent.find(optionBoxUnChecked).prop
        disabled: false
      hide submit


  $(form).on 'ajax:success', ->
    slideTo '<%= edit_character_path(@move.character) %>'

  $(body).click ->
    $(this).parent().find(radio).click()

  fadeInBody()
