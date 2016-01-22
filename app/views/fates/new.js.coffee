$ ->
  console.log '\nCHOOSE FATE'
  data = '<%= escape_javascript render "new" %>'
  fateBody = '.fate-body'
  radio = 'input[type=radio]'
  submitButton = '#submit-button'
  form = "#new_fate"

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
      slideQuietlyTo '<%= character_path(@character.id) %>'

  fadeInBody()
