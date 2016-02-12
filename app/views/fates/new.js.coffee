$ ->
  data = '<%= escape_javascript render "new" %>'
  fateBody = '.fate-body'
  radio = 'input[type=radio]'
  submitButton = '#submit-button'
  form = "#new_fate"

  load data

  startHidden submitButton

  $(fateBody).click ->
    $(this).parent().find(radio).click()

  $(radio).change ->
    show submitButton

  $(submitButton).redirectButtonTo ->
    fadeOutBody ->
      $(form).submit()
      slideQuietlyTo '<%= character_path(@character.id) %>'

  fadeInBody()
