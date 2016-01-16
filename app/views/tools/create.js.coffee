$ ->
  console.log '\nCREATE TOOL'
  data = '<%= escape_javascript render partial: "tools/tool_list.html.erb", locals: {tools: @character.tools} %>'
  numTools = parseInt('<%= @character.tools.count %>')
  toolList = '#tool-list'
  nameField = '#tool-name'
  descriptionField = '#tool-description'
  textFields = '#tool-text'
  form = '#new_tool'
  editToolFormSlider = '#edit-tool-form-slider'
  defTool = '<%=@tool.def_tool.id%>'
  radio = '#tool_def_tool_id_' + defTool
  editToolLink = 'a.edit_tool'
  done = '#tools-done'
  $(radio).prop
    checked: false
    disabled: true
  # fadeOut toolList, ->
  $(toolList).html(data)
  $(editToolLink).click (e) ->
    console.log '\nCLICK EDIT TOOL'
    href = $(this).attr('href')
    dataMethod = $(this).attr('data-method')
    hide form, ->
      fadeOut editToolFormSlider, ->
        request href, dataMethod
    return false
  show toolList
  if numTools >= 3
    show done
    $(done).focus()
  else
    $('input[type=radio]:not(:disabled):first').focus()
