$ ->
  console.log '\nCHOOSE FATE'
  data = '<%= escape_javascript render "edit" %>'
  fateBody = '.fate-body'
  radio = 'input[type=radio]'
  submitButton = '#submit-button'
  form = "form"

  load data

  startHidden submitButton

  $(fateBody).click ->
    console.log '\nCLICK FATE BODY'
    $(this).parent().find(radio).click()

  $(radio).change ->
    console.log '\nCHANGE RADIO'
    show submitButton

  $(submitButton).redirectButtonTo ->
    console.log '\nSUBMIT'
    fadeOutBody ->
      $(form).submit()

  $(form).on 'ajax:success', ->
    slideTo '<%= character_path(@character.id) %>'

  fadeInBody()
