$ ->
  console.log '\nEDIT VOWS'
  data = '<%= escape_javascript render "edit_vows"%>'
  load data

  vows = '<%=
    result = ""
    @character.vows.each do |v|
      result += " #def_vow_ids_#{v.def_vow.id}"
    end
    result.strip!
  %>'.split ' '
  console.log vows

  checkbox = 'input[type=checkbox]'
  submit = "input[type=submit]"
  form = 'form'

  $(checkbox).prop
    checked: false

  if vows[0]
    $(v).prop(checked: true) for v in vows


  if $(checkbox + ":checked").length >= 2
    $(checkbox + ':not(:checked)').prop
      disabled: true
  else
    startHidden submit

  $('.body').click ->
    console.log '\nCLICK FORM'
    $(this).parent().find(checkbox).click()
    return false

  $(checkbox).change ->
    console.log '\nCHANGE CHECKBOX'
    if $(this).is(":checked")
      disabled = false
    else
      disabled = true

    # $(this).closest('form').children(detail)
    if $(checkbox + ":checked").length >= 2
      $(checkbox + ':not(:checked)').prop
        disabled: true
      show submit
    else
      $(checkbox + ':disabled').prop
        disabled: false
      hide submit

  $(submit).redirectButtonTo ->
    fadeOutBody ->
      $(form).submit()

  $(form).on 'ajax:success', ->
    slideTo '<%= edit_character_path(@character) %>'

  fadeInBody()
