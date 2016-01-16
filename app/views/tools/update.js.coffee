$ ->
  console.log '\nUPDATE TOOL'
  data = '<%= escape_javascript render "new" %>'
  fadeOutBody()
  load data()
