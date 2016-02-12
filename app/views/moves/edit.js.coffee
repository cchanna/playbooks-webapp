$ ->
  data = '<%= escape_javascript render "edit" %>'
  load data

  form = "form"
  submit = ".submit"
  radio = 'input[type=radio]'
  body = '.body'

  unless $(radio).is(":checked")
    startHidden submit

  $(submit).redirectButtonTo ->
    fadeOutBody ->
      $(form).submit()

  $(radio).change ->
    show submit

  $(form).on 'ajax:success', ->
    slideTo '<%= character_path(@move.character) %>'

  $(body).click ->
    $(this).parent().find(radio).click()

  fadeInBody()
