$ ->
  submitButton = undefined
  console.log 'new character'
  data = '<%= escape_javascript render "characters/new.html.erb" %>'
  load data
  submitButton = '#new-character-form #submit-button'
  startHidden submitButton

  $('input[type=radio]').change ->
    console.log 'click radio'
    show submitButton

  $('#new-character-form').on 'ajax:success', (e, data, status, xhr) ->
    console.log '\nFORM SUBMIT'
    slideTo data

  fadeIn()
