$ ->
  data = '<%= escape_javascript render "new" %>'
  questions = '<%=
    result = ""
    @character.relationships.each do |r|
      result += " #trust-question-#{r.trust_question.id}"
    end
    result.strip!
  %>'.split ' '
  hideForm = '<%= @character.relationships.count == @character.archetype.trust_questions.count %>'
  canContinue = '<%= @character.relationships.count > 0%>'
  form = '#new_relationship'
  submitButton = '#submit-button'
  textField = '#trust-name'
  deleteButton = '.delete_relationship'
  done = '#relationships-done'
  relationshipList = '#relationship-list'
  trustQuestionsList = '#trust-questions-list'

  load data

  if hideForm == 'true'
    startFaded form

  unless canContinue == 'true'
    startHidden done

  startHidden submitButton
  startHidden textField

  $('input[type=text]').prop
    autocomplete: 'off'

  if questions[0]
    $(q + ' input').prop(checked: false, disabled: true) for q in questions

  beforeSubmit = ->
    if $("input[type=radio]").is(':checked') && $(textField).val()
      hide textField
      hide submitButton
      fadeOut relationshipList, ->
        $(form).submit()
        $(textField).val("")

  $(textField).redirectReturnTo beforeSubmit
  $(submitButton).redirectButtonTo beforeSubmit

  $('input[type=radio]').redirectRadioTo (me) ->
    if $(me).prop("checked")
      if $(textField).css('display') == 'none'
        $(textField).val ""
        show textField
        $(textField).focus()
      else
        hide submitButton
        fadeOut textField, ->
          $(textField).val ""
          show textField
          $(textField).focus()
    else
      hide textField

  $(deleteButton).redirectButtonTo (me) ->
    href = $(me).attr("href")
    method = $(me).data("method")
    fadeOut relationshipList, ->
      request href, method

  $(form).keyup (e) ->
    if $(textField).val()
      if $(submitButton).css('display') == 'none'
        show submitButton
    else
      hide submitButton

  fadeInBody()
