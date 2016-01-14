$ ->
  console.log 'edit character'
  data = '<%=
    if params[:field] == "name"
      escape_javascript render "edit_name"
    else
      escape_javascript render "edit"
    end  %>'
  load data

  submitButton = '#edit-character-form .submit-button'
  alternateForm = '#alternate-form-1'
  alternateSubmitButton = '#alternate-form-1 .submit-button'

  hide = (element, doFollowup) ->
    if $(element).css("display") == 'none'
      doFollowup() if doFollowup?
    else
      console.log 'hide ' + element
      $(element).animate opacity: 0, 300, ->
        $(element).css display: 'none'
        doFollowup() if doFollowup?

  show = (element) ->
    unless $(element).css("display") == 'block'
      console.log 'show ' + element
      $(element).css display: 'block'
      $(element).animate opacity: 1, 300

  unless '<%= @character.name %>' == ''
    if '<%= @character.archetype.sample_names.find_by(name: @character.name) %>' == ''
      show alternateForm
      show alternateSubmitButton

  fadeIn()


  $('.edit-character-form').on 'ajax:success', (e, data, status, xhr) ->
    console.log '\nFORM SUBMIT'
    slideQuietlyTo data

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
