$ ->
  console.log 'show character'
  redirectUrl = '<%=
    if !@character.name?
      edit_character_path(id: @character.id, field: "name")
    elsif @character.def_looks.count == 0
      edit_character_path(id: @character.id, field: "look")
    elsif @character.relationships.count == 0
      new_character_relationship_path(character_id: @character.id)
    elsif @character.archetype == Archetype.find_by(name: "Scoundrel") && @character.tools.count == 0
      new_character_tool_path(character_id: @character.id)
    elsif @character.moves.count == 0
      edit_moves_character_path(id: @character.id)
    end %>'
  console.log redirectUrl
  if redirectUrl
    console.log '\nREDIRECT'
    slideQuietlyTo redirectUrl
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