$ ->
  console.log 'new relationship'
  data = '<%= escape_javascript render "new" %>'
  questions = '<%=
    result = ""
    @character.relationships.each do |r|
      result += " #trust-question-#{r.trust_question.id}"
    end
    result.strip!
  %>'.split ' '
  console.log questions
  hideForm = '<%= @character.relationships.count == @character.archetype.trust_questions.count %>'
  canContinue = '<%= @character.relationships.count > 0%>'
  form = '#new_relationship'
  submitButton = '#submit-button'
  textField = '#trust-name'
  done = '#relationships-done'
  relationshipList = '#relationship-list'
  load data
  # startFaded q for q in questions
  if questions[0]
    $(q + ' input').prop(checked: false, disabled: true) for q in questions
  if hideForm == 'true'
    startFaded form
  startHidden submitButton
  startHidden textField
  unless canContinue == 'true'
    startHidden done

  $('#new_relationship').submit (e) ->
    console.log '\nBEFORE FORM SUBMIT'
    unless $(textField).val()
      console.log 'cancel submit'
      return false

  $('input[type=radio]').change ->
    console.log 'click question'
    show textField
    $(textField).focus()

  $(textField).keyup ->
    if $(this).val()
      if $(submitButton).css('display') == 'none'
        show submitButton
    else
      hide submitButton

  fadeInBody()
  #
  # $('#new-character-form').on 'ajax:success', (e, data, status, xhr) ->
  #   console.log '\nFORM SUBMIT'
  #   slideTo data
