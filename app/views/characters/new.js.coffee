$ ->
  submitButton = undefined
  data = '<%= escape_javascript render "characters/new.html.erb" %>'
  load data
  form = "#new-character-form"
  submitButton = '#new-character-form #submit-button'
  startHidden submitButton

  $('input[type=radio]').redirectRadioTo ->
    show submitButton

  $(submitButton).redirectButtonTo ->
    fadeOutBody ->
      $(form).submit()

  $(form).on 'ajax:success', (e, data, status, xhr) ->
    slideTo data

  fadeInBody()
