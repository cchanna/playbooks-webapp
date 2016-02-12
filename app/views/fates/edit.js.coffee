$ ->
  data = '<%= escape_javascript render "edit" %>'
  fateBody = '.fate-body'
  radio = 'input[type=radio]'
  submitButton = '#submit-button'
  form = "form"

  load data

  startHidden submitButton

  $(fateBody).click ->
    $(this).parent().find(radio).click()

  $(radio).change ->
    show submitButton

  $(submitButton).redirectButtonTo ->
    fadeOutBody ->
      $(form).submit()

  $(form).on 'ajax:success', ->
    slideTo '<%= character_path(@character.id) %>'

  fadeInBody()
