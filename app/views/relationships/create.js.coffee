$ ->
  console.log '\nCREATE RELATIONSHIP'
  data = '<%= escape_javascript render partial: "characters/relationship_list.html.erb", locals: {relationships: @character.relationships} %>'
  question = '#trust-question-<%=@relationship.trust_question.id%>'
  radio = '#relationship_trust_question_id_<%=@relationship.trust_question.id%>'
  hideForm = '<%= @character.relationships.count == @character.archetype.trust_questions.count %>'
  console.log hideForm
  submitButton = '#submit-button'
  textField = '#trust-name'
  done = '#relationships-done'
  relationshipList = '#relationship-list'
  trustEnterName = '#trust-enter-name'
  form = '#new_relationship'
  # fadeOut question
  # fadeOutRadio radio
  console.log radio
  $(radio).prop
    checked: false
    disabled: true
  fadeOut relationshipList, ->
    $(relationshipList).html(data)
    show relationshipList
  if hideForm == 'true'
    fadeOut form
  $(textField).val("")
  fadeOut textField
  hide submitButton
  show done
