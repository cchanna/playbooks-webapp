$ ->
  data = '<%= render partial: "edit" %>'
  load data

  form = 'form'
  improvement = '.improvement'
  radio = '.improvement-radio'
  options = '#improvement-options'
  remove = '.delete'

  $(radio).redirectRadioTo (me) ->
    $(form).submit()

  $(form).on 'ajax:success', (e, data, status, xhr) ->
    a = $.parseHTML($.trim(data))
    b = $.parseHTML($.trim($(options).html()))
    unless (a and b) and (a.length is b.length) and (a.every (elem, i) -> "#{elem}" is "#{b[i]}")
        growReplace options, data

  $(remove).on 'ajax:success', ->
    slideTo '<%= edit_character_path(@character) %>'

  fadeInBody()
