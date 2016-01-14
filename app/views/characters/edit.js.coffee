$ ->
  submitButton = undefined
  console.log 'edit character'
  data = '<%=
    if params[:field] == "name"
      escape_javascript render "edit_name"
    else
      escape_javascript render "edit"
    end  %>'
  load data
  fadeIn()
  submitButton = '#edit-character-form #submit-button'

  $('#edit-character-form').on 'ajax:success', (e, data, status, xhr) ->
    console.log '\nFORM SUBMIT'
    slideQuietlyTo data
