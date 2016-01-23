$ ->
  console.log '\nEDIT GIFT'
  data = '<%= escape_javascript render "edit" %>'
  load data

  detailField = "input[type=text]"
  radio = "input[type=radio]"
  curseRadio = "#{radio}.curse-radio"
  typeRadio = "#{radio}.type-radio"
  curse = ".curse"
  submit = "input[type=submit]"
  description = "textarea"
  curses = ".curse-list"
  form = "form"

  startingDetailField = $("#{curseRadio}:checked").closest(curse).find(detailField)
  unless (startingDetailField.length > 0 && startingDetailField.val())
    startHidden submit
    unless $(curseRadio).is(":checked")
      startHidden submit
      unless $(description).val()
        startHidden curses
        unless $(typeRadio).is(":checked")
          startHidden description

  $(detailField).each ->
    unless $(this).closest(curse).find(radio).is(":checked")
      $(this).prop
        disabled: true

  $(typeRadio).change ->
    hide description, ->
      $(description).val ""
      show description
      $(description).select()
    hide curses, ->
      $(curseRadio).prop(checked: false)
    hide submit
    $(detailField).prop
      disabled: true
    $(detailField).val ""

  $(description).keyup (e) ->
    if e.which != 13
      if $(description).val()
        show curses
      else
        hide curses, ->
          $(curseRadio).prop(checked: false)
        hide submit
        $(detailField).prop
          disabled: true
        $(detailField).val ""

  $(curseRadio).change ->
    $(detailField).prop
      disabled: true
    $(detailField).val ""
    df = $(this).closest(curse).find(detailField)
    if df.length > 0
      hide submit
      df.prop
        disabled: false
      df.select()
    else
      show submit
      $(submit).focus()

  $(detailField).keyup (e) ->
    if e.which != 13
      if $(this).val()
        show submit
      else
        hide submit

  onSubmit = ->
    if $(typeRadio).is(":checked") && $(description).val() && $(curseRadio).is(":checked")
      df = $("#{curseRadio}:checked").closest(curse).find(detailField)
      if (df.length == 0 || df.val())
        fadeOutBody ->
          $(form).submit()
          slideQuietlyTo '<%= character_path(@gift.character.id) %>'
    return false

  $(description).redirectReturnTo ->
    $(curseRadio).first().focus()
  $(detailField).redirectReturnTo onSubmit
  $(submit).redirectButtonTo onSubmit

  fadeInBody()
