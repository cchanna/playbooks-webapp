$ ->
  data = '<%= render partial: "edit" %>'
  load data

  form = 'form'
  improvement = '.improvement'
  radio = '.improvement-radio'
  options = '#improvement-options'
  remove = '.delete'

  $(radio).redirectRadioTo (me) ->
    console.log 'hello'
    $(form).submit()

  $(form).on 'ajax:success', (e, data, status, xhr) ->

    a = $.parseHTML($.trim(data))
    b = $.parseHTML($.trim($(options).html()))
    if (a.length is b.length) and (a.every (elem, i) -> "#s{elem}" is "#{b[i]}")
      growReplace options, data

  $(remove).on 'ajax:success', ->
    slideTo '<%= edit_character_path(@character) %>'

  fadeInBody()
