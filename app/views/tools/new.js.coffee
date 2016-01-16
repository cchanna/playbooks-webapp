$ ->
  console.log '\nNEW TOOL'
  numTools = parseInt('<%= @character.tools.count %>')
  numNewTools = 0
  data = '<%= escape_javascript render "new" %>'
  load data
  $('input[type=checkbox]').change ->
    console.log '\nCLICK TOOL'
    if $(this).is(':checked')
      numNewTools++
      console.log count = numTools + numNewTools
      if numTools + numNewTools >= 3
        $('input:not(:checked)').prop
          disabled: true
    else
      numNewTools--
      console.log count = numTools + numNewTools
      if numTools + numNewTools < 3
        $('input:disabled').prop
            disabled: false
    # show textField
    # $(textField).focus()
  fadeInBody()
