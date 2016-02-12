$ ->
  redirectURL = '<%=
    if !@character.name? || @character.def_looks.count == 0 ||
                            @character.relationships.count == 0 ||
                            @character.fates.count == 0 ||
                            (@character.archetype == Archetype.find_by(name: "Scoundrel") &&
                             @character.tools.count == 0) ||
                            @character.moves.where(def_move_id: nil).count > 0
      edit_character_path(id: @character.id)
    elsif !@character.gift.nil? && @character.gift.gift_type.nil?
      edit_gift_path(id: @character.gift.id)
    end %>'
  if redirectURL
    slideQuietlyTo redirectURL
    return

  data = '<%= escape_javascript render "show" %>'
  incrementFate = '.increment-fate'
  decrementFate = '.decrement-fate'

  load data

  onIncrement = (me) ->
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
      $("#complete-fate-#{id}").prop disabled: false

  onDecrement = (me) ->
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
      # hide "#complete-fate-#{id}"
      $("#complete-fate-#{id}").prop disabled: true

  changeToIncrement = (button) ->
    buttonClass = $(button).attr("class").replace "decrement", "increment"
    $(button).attr(class: buttonClass)
    $(button).val("O")
    action = $(button).parent().attr("action").replace "decrement", "increment"
    $(button).parent().attr(action: action)
    $(button).off()
    $(button).redirectButtonTo onIncrement

  changeToDecrement = (button) ->
    buttonClass = $(button).attr("class").replace "increment", "decrement"
    $(button).attr(class: buttonClass)
    $(button).val("@")
    action = $(button).parent().attr("action").replace "increment", "decrement"
    $(button).parent().attr(action: action)
    $(button).off()
    $(button).redirectButtonTo onDecrement

  onComplete = (me) ->
    fate = $(me).closest(".fate")
    id = $(fate).attr('id').split("-")[1]
    if $(fate).data("value") == 5 && $(fate).data("completed") == false
      $(fate).data(completed: true)
      $(".change-fate-#{id}").prop disabled: true
      $(me).submit()
      changeToUncomplete me

  onUncomplete = (me) ->
    fate = $(me).closest(".fate")
    id = $(fate).attr('id').split("-")[1]
    if $(fate).data("completed") == true
      $(fate).data(completed: false)
      $(me).submit()
      $(".change-fate-#{id}").prop disabled: false
      changeToComplete me

  changeToComplete = (button) ->
    buttonClass = $(button).attr("class").replace "uncomplete", "complete"
    $(button).attr(class: buttonClass)
    action = $(button).parent().attr("action").replace "uncomplete", "complete"
    $(button).parent().attr(action: action)
    $(button).off()
    $(button).redirectButtonTo onComplete

  changeToUncomplete = (button) ->
    buttonClass = $(button).attr("class").replace "complete", "uncomplete"
    $(button).attr(class: buttonClass)
    action = $(button).parent().attr("action").replace "complete", "uncomplete"
    $(button).parent().attr(action: action)
    $(button).off()
    $(button).redirectButtonTo onUncomplete

  setFate = (fate) ->
    advancement = $(fate).find(".fate-advancement")
    id = $(fate).attr('id').split("-")[1]
    value = $(fate).data("value")
    completed = $(fate).data("completed")
    tag = "#change-fate-#{id}"
    j = 1
    $(tag).redirectButtonTo onIncrement
    while j <= value
      changeToDecrement "#{tag}-#{j}"
      j++
    if j < 5
      $("#complete-fate-#{id}").prop disabled: true
    while j <= 5
      changeToIncrement "#{tag}-#{j}"
      j++
    if completed
      $(".change-fate-#{id}").prop disabled: true
      changeToUncomplete "#complete-fate-#{id}"
    else
      changeToComplete "#complete-fate-#{id}"

  setFate fate for fate in $(".fate")

  $(".trust-change").on 'ajax:success', (e, data, status, xhr) ->
    value = '#trust-value-' + $(this).children('input[type=submit]').data('trust-id')
    hide value, ->
      $(value).html(data)
      show value

  onDecrementSpirit = (me) ->
    $(me).submit()
    hide me, ->
      $(me).parent().remove()


  $(".decrement_spirit").redirectButtonTo onDecrementSpirit

  $(".increment_spirit").redirectButtonTo (me) ->
    $(me).submit()

  $(".increment_spirit").parent().on 'ajax:success', (e, data, status, xhr) ->
    newButton = $('#spirit-buttons').append(data)
    $(newButton).find(".decrement_spirit").redirectButtonTo onDecrementSpirit

  $(".dire-fate-checkbox").change ->
    $(this).submit()

  onMoveFieldDelete = (me) ->
    moveField = $(me).closest(".move-field")
    deleteForm = $(me).parent()
    hide moveField, ->
      deleteForm.submit()
      moveField.remove()

  $(".move-field-delete").redirectButtonTo onMoveFieldDelete

  $(".move-field-add").parent().on 'ajax:success', (e, data, status, xhr ) ->
    addButton = $(this)
    addButton.prop
      disabled: true
    fields = $(this).parent()
    hide addButton, ->
      fieldForm = fields.find(".move-fields").append(data).children().last()
      fieldSubmit = fieldForm.find(".move-field-add-submit")
      fieldCancel = fieldForm.find(".move-field-add-cancel")
      fieldInput = fieldForm.find(".move-field-add-input")
      startHidden fieldForm
      startHidden fieldSubmit
      show fieldForm
      fieldInput.select()
      fieldInput.keyup (e) ->
        if e.which != 13
          if fieldInput.val()
            hide fieldCancel, ->
              show fieldSubmit
          else
            hide fieldSubmit, ->
              show fieldCancel
      fieldCancel.redirectButtonTo ->
        hide fieldForm, ->
          fieldForm.remove()
          show addButton
      fieldSubmit.redirectButtonTo ->
        fadeOut fieldForm, ->
          fieldForm.submit()
      $(".move-field-add-input").on 'keypress', (e) ->
        if e.which == 13
          if fieldCancel.css("display") == "none"
            fadeOut fieldForm, ->
              fieldForm.submit()
          else
            hide fieldForm, ->
              fieldForm.remove()
              show addButton

      fieldForm.on 'ajax:success', (e, data, status, xhr) ->
        fieldForm.remove()
        newField = fields.find(".move-fields").append(data).children().last()
        newField.find(".move-field-delete").redirectButtonTo onMoveFieldDelete
        startHidden newField
        show newField
        show addButton



  fadeInBody()
