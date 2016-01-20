$ ->
  submitButton = undefined
  console.log 'new character'
  data = '<%= escape_javascript render "characters/new.html.erb" %>'
  load data
  form = "#new-character-form"
  submitButton = '#new-character-form #submit-button'
  startHidden submitButton

  $('input[type=radio]').redirectRadioTo ->
    console.log 'click radio'
    show submitButton

  $(submitButton).redirectButtonTo ->
    fadeOutBody ->
      $(form).submit()
      
  $(form).on 'ajax:success', (e, data, status, xhr) ->
    console.log '\nFORM SUBMIT'
    slideTo data

  fadeInBody()
