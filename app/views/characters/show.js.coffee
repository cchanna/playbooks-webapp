$ ->
  console.log 'show character'
  redirectUrl = '<%=
    if !@character.name?
      edit_character_path(id: @character.id, field: "name")
    elsif @character.relationships.count == 0
      new_character_relationship_path(character_id: @character.id)
    end %>'
  console.log redirectUrl
  if redirectUrl
    console.log '\nREDIRECT'
    slideTo redirectUrl
    return

  data = '<%= escape_javascript render "show" %>'
  console.log data
  load data

  $(".trust-change").on 'ajax:success', (e, data, status, xhr) ->
    console.log 'change trust'
    console.log data
    value = '#trust-value-' + $(this).children('input[type=submit]').data('trust-id')
    hide value, ->
      $(value).html(data)
      show value

  fadeInBody()
