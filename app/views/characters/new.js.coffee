$ ->
  submitButton = undefined
  console.log 'new character'
  data = '<%= escape_javascript render "characters/new.html.erb" %>'
  load data
  fadeIn()
  submitButton = '#new-character-form #submit-button'

  clickRadio = ->
    console.log 'click radio'
    $(submitButton).css display: 'inline'
    $(submitButton).animate
      opacity: 1
      duration: 300

  # $('.new-character-form-radio').click clickRadio
  # $('.new-character-form-radio-label').click clickRadio
  $('input[type=radio]').change clickRadio

  $('#new-character-form').on 'ajax:success', (e, data, status, xhr) ->
    console.log '\nFORM SUBMIT'
    slideTo data
