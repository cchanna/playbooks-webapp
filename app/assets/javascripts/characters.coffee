$.fn.extend
  slideTo: (data) ->
    return @each () ->
      $(this).animate {opacity: 0}, 300, ->
        $(this).html(data)
        $(this).animate(opacity: 1, duration: 300)

$ ->
  here = location.pathname

  init = ->
    # page load

  fadeTo = (url) ->
    history.pushState null, '', url
    init()
    $.ajax(url: url, dataType: "script").always (data) =>
      $('#slider').slideTo data.responseText

  if $('#slider').html().trim() == ""
    fadeTo here

  $(window).on 'popstate', (e) ->
    console.log e
    console.log e.originalEvent
    console.log e.originalEvent.state == null
    if e.originalEvent.state == null
      e.preventDefault()
      fadeTo here
    else
      history.back()

  $(document).on 'click', '#slider a', (e) ->
    href = $(this).attr('href')
    if href.indexOf(document.domain) > -1 or href.indexOf(':') == -1
      e.preventDefault()
      fadeTo href
