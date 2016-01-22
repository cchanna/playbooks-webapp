$ ->
  console.log 'show character'
  redirectUrl = '<%=
    if !@character.name?
      edit_character_path(id: @character.id, field: "name")
    elsif @character.fates.count == 0
      new_character_fate_path(character_id: @character.id)
    elsif @character.def_looks.count == 0
      edit_character_path(id: @character.id, field: "look")
    elsif @character.relationships.count == 0
      new_character_relationship_path(character_id: @character.id)
    elsif @character.archetype == Archetype.find_by(name: "Scoundrel") && @character.tools.count == 0
      new_character_tool_path(character_id: @character.id)
    elsif @character.moves.count == 0
      edit_moves_character_path(id: @character.id)
    end %>'
  if redirectUrl
    console.log '\nREDIRECT TO ' + redirectURL
    slideQuietlyTo redirectUrl
    return

  data = '<%= escape_javascript render "show" %>'
  incrementFate = '.increment-fate'
  decrementFate = '.decrement-fate'
  i=0

  load data

  onIncrement = (me) ->
    console.log '\nINCREMENT FATE'
    parent = $(me).closest(".fate")
    id = $(parent).attr('id').split("-")[1]
    value = $(parent).data("value")
    if value < 5
      $(me).submit()
      value++
      $(parent).data(value: value)
      tag = "#change-fate-#{id}-#{value}"
      changeToDecrement tag
    if value == 5
      show "#complete-fate-#{id}"

  onDecrement = (me) ->
    console.log '\nDECREMENT FATE'
    parent = $(me).closest(".fate")
    id = $(parent).attr('id').split("-")[1]
    value = $(parent).data("value")
    if value > 0
      $(me).submit()
      tag = "#change-fate-#{id}-#{value}"
      value--
      $(parent).data(value: value)
      changeToIncrement tag
    if value < 5
      hide "#complete-fate-#{id}"

  changeToIncrement = (button) ->
    console.log 'change ' + button + ' to increment'
    buttonClass = $(button).attr("class").replace "decrement", "increment"
    console.log buttonClass
    $(button).attr(class: buttonClass)
    $(button).val("O")
    action = $(button).parent().attr("action").replace "decrement", "increment"
    $(button).parent().attr(action: action)
    $(button).off()
    $(button).redirectButtonTo onIncrement

  changeToDecrement = (button) ->
    console.log 'change ' + button + ' to decrement'
    buttonClass = $(button).attr("class").replace "increment", "decrement"
    console.log buttonClass
    $(button).attr(class: buttonClass)
    $(button).val("@")
    action = $(button).parent().attr("action").replace "increment", "decrement"
    $(button).parent().attr(action: action)
    $(button).off()
    $(button).redirectButtonTo onDecrement

  setFate = (fate) ->
    console.log fate
    advancement = $(fate).find(".fate-advancement")
    id = $(fate).attr('id').split("-")[1]
    console.log id
    value = $(fate).data("value")
    console.log value
    completed = $(fate).data("completed")
    console.log completed
    tag = "#change-fate-#{id}"
    j = 1
    while j <= value
      changeToDecrement "#{tag}-#{j}"
      j++
    if j < 5
      startHidden "#complete-fate-#{id}"
    while j <= 5
      changeToIncrement "#{tag}-#{j}"
      j++
    if completed
      $(".change-fate-#{id}").prop disabled: true
      startHidden "#complete-fate-#{id}"
    else
      startHidden "#uncomplete-fate-#{id}"

  setFate fate for fate in $(".fate")

  $('.complete-fate').redirectButtonTo (me) ->
    fate = $(me).closest(".fate")
    id = $(fate).attr('id').split("-")[1]
    if $(fate).data("value") == 5
      $(".change-fate-#{id}").prop disabled: true
      $(me).submit()
      hide me, ->
        show "#uncomplete-fate-#{id}"

  $('.uncomplete-fate').redirectButtonTo (me) ->
    fate = $(me).closest(".fate")
    id = $(fate).attr('id').split("-")[1]
    $(me).submit()
    $(".change-fate-#{id}").prop disabled: false
    hide me, ->
      show "#fate-advancement-#{id}"
      show "#complete-fate-#{id}"

  $(".trust-change").on 'ajax:success', (e, data, status, xhr) ->
    console.log 'change trust'
    console.log data
    value = '#trust-value-' + $(this).children('input[type=submit]').data('trust-id')
    hide value, ->
      $(value).html(data)
      show value


  # $('body').on 'click', 'a.disabled', (event) ->
  #   event.preventDefault()

  fadeInBody()
