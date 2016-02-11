$ ->
  data = '<%= escape_javascript render "edit" %>'
  load data

  form = "form"
  submit = ".submit"

  $(submit).redirectButtonTo ->
    fadeOutBody ->
      $(form).submit()
      slideTo '<%= edit_character_path(@move.character) %>' 


  fadeInBody()
