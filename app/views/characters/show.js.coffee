$ ->
  console.log 'show character'
  redirectUrl = '<%=
    unless @character.name?
      edit_character_path(id: @character.id, field: "name")
    end %>'
  console.log redirectUrl
  if redirectUrl
    console.log '\nREDIRECT'
    slideTo redirectUrl
  else
    data = '<%= escape_javascript render "show" %>'
    console.log data
    load data
    fadeIn()
