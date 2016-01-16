$ ->
  console.log '\nDESTROY RELATIONSHIP'
  data = '<%= escape_javascript render partial: "relationships/relationship_list.html.erb", locals: {relationships: @character.relationships} %>'
  question_id = '<%=@question_id%>'
  question = '#trust-question-' + question_id
  radio = '#relationship_trust_question_id_' + question_id
  form = '#new_relationship'
  relationshipList = '#relationship-list'
  canContinue = '<%= @character.relationships.count > 0%>'
  done = '#relationships-done'
  textField = '#trust-name'
  # show question
  show form
  if canContinue == 'false'
    fadeOut done
  unless $(textField).css('opacity') == 0
    $(textField).focus()
  fadeOut relationshipList, ->
    $(relationshipList).html(data)
    show relationshipList
    $(radio).prop
      disabled: false
