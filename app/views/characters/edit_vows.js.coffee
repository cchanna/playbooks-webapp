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
  detail = "input[type=text]"
  form = 'form'

  $(checkbox).prop
    checked: false

  if vows[0]
    $(v).prop(checked: true) for v in vows


  valid = ->
    v = true
    $(checkbox + ':checked').parent().find(detail).each ->
      console.log $(this).val()
      unless $(this).val()
        v = false
    return v

  setSubmit = ->
    if $(checkbox + ":checked").length >= 2
      $(checkbox + ':not(:checked)').prop
        disabled: true
      if valid()
        show submit
      else
        hide submit
    else
      $(checkbox + ':disabled').prop
        disabled: false
      hide submit

  if $(checkbox + ":checked").length >= 2
    $(checkbox + ':not(:checked)').prop
      disabled: true
    unless valid()
      startHidden submit
  else
    startHidden submit

  $('.body').click ->
    console.log '\nCLICK FORM'
    $(this).parent().find(checkbox).click()
    return false

  $(detail).click ->
    return false;

  $(detail).keyup ->
    setSubmit()




  $(checkbox).change ->
    console.log '\nCHANGE CHECKBOX'

    thisDetail = $(this).parent().find(detail)
    thisDetail.prop
      disabled: !$(this).is(":checked")
    thisDetail.val ""

    setSubmit()

    thisDetail.focus()

  $(submit).redirectButtonTo ->
    fadeOutBody ->
      $(form).submit()

  $(form).on 'ajax:success', ->
    slideTo '<%= edit_character_path(@character) %>'

  fadeInBody()
