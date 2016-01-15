$ ->
  # submitButton = undefined
  console.log 'new relationship'
  data = '<%= escape_javascript render "new" %>'
  load data
  submitButton = '#submit-button'
  textField = '#trust-name'
  startHidden submitButton
  startHidden textField


  $('#new_relationship').submit (e) ->
    console.log '\nBEFORE FORM SUBMIT'
    unless $(textField).val()
      console.log 'cancel submit'
      return false

  $('#new_relationship').on 'ajax:success', (e, data, status, xhr) ->
    console.log '\nFORM SUBMIT'
    slideQuietlyTo data

  $('input[type=radio]').change ->
    console.log 'click question'
    show textField

  $(textField).keyup ->
    if $(this).val()
      show submitButton
    else
      hide submitButton

  fadeIn()
  #
  # $('#new-character-form').on 'ajax:success', (e, data, status, xhr) ->
  #   console.log '\nFORM SUBMIT'
  #   slideTo data
