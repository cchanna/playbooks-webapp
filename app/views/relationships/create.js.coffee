$ ->
  console.log '\nCREATE RELATIONSHIP'
  data = '<%= escape_javascript render partial: "relationships/relationship_list.html.erb", locals: {relationships: @character.relationships} %>'
  question = '#trust-question-<%=@relationship.trust_question.id%>'
  radio = '#relationship_trust_question_id_<%=@relationship.trust_question.id%>'
  hideForm = '<%= @character.relationships.count == @character.archetype.trust_questions.count %>'
  submitButton = '#submit-button'
  textField = '#trust-name'
  done = '#relationships-done'
  relationshipList = '#relationship-list'
  trustEnterName = '#trust-enter-name'
  form = '#new_relationship'
  deleteButton = '.delete_relationship'
  $(radio).prop
    checked: false
    disabled: true
  $(relationshipList).html(data)
  show relationshipList
  if hideForm == 'true'
    hide form
  $(textField).val("")
  hide textField
  hide submitButton

  $(deleteButton).redirectButtonTo (me) ->
    console.log '\nCLICK DESTROY RELATIONSHIP'
    href = $(me).attr("href")
    method = $(me).data("method")
    fadeOut relationshipList, ->
      request href, method

  show done
  $(done).focus()
