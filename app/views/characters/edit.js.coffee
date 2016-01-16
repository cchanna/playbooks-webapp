$ ->
  console.log 'edit character'
  data = '<%=
    case params[:field]
    when "name"
      escape_javascript render "edit_name"
    when "trust"
      escape_javascript render "edit_trust"
    else
      escape_javascript render "edit"
    end  %>'
  load data

  submitButton = '#edit-character-form .submit-button'
  startHidden submitButton
  alternateForm = '#alternate-form-1'
  startHidden alternateForm
  alternateSubmitButton = '#alternate-form-1 .submit-button'
  startHidden alternateSubmitButton

  unless '<%= @character.name %>' == ''
    if '<%= @character.archetype.sample_names.find_by(name: @character.name) %>' == ''
      show alternateForm
      show alternateSubmitButton

  $('.edit-character-form').on 'ajax:success', (e, data, status, xhr) ->
    console.log '\nFORM SUBMIT'
    slideQuietlyTo data

  $('#alternate-form-1').submit (e) ->
    console.log '\nBEFORE FORM SUBMIT'
    unless $('input[type=text]').val()
      console.log 'cancel submit'
      return false

  $('input[type=radio].sample-name').change ->
    console.log 'click sample name'
    hide alternateForm, ->
      show submitButton

  $('input[type=radio].name-category').change ->
    console.log 'click name category'
    hide submitButton, ->
      show alternateForm

  $('input[type=text]').keyup ->
    if $(this).val()
      show alternateSubmitButton
    else
      hide alternateSubmitButton

  fadeInBody()
