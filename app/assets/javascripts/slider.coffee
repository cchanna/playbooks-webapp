init = (here) ->
  if here == Routes.new_character_path()
    submitButton = '#new-character-form #submit-button'
    $('.new-character-form-radio').click ->
      $(submitButton).css(display: 'inline')
      $(submitButton).animate {opacity: 1, duration: 300}
      $('#new-character-form').on 'ajax:success', (e,data,status,xhr) ->
        fadeTo data, init
        console.log(e)
        console.log(data)
        console.log(status)
        console.log(xhr)

$.fn.extend
  slideTo: (data, url) ->
    return @each () ->
      $(this).animate {opacity: 0}, 300, ->
        $(this).html(data)
        if url?
          init(url)
        $(this).animate(opacity: 1, duration: 300)

fadeTo = (url) ->
  $.ajax(url: url, dataType: "script").always (data) =>
    history.pushState null, '', url
    $('#slider').slideTo data.responseText, url


$ ->
  here = location.pathname




  postTo = (url) ->
    $.ajax(type: "POST", url: url, dataType: "script")

  if $('#slider').html().trim() == ""
    fadeTo here, init

  $(window).on 'popstate', (e) ->
    if e.originalEvent.state == null
      e.preventDefault()
      fadeTo here, init
    else
      history.back()

  # $(document).on 'click', '#slider input[type=submit]', (e) ->
    # e.preventDefault()
    # console.log "hello"

  $(document).on 'click', '#slider a', (e) ->
    href = $(this).attr('href')
    if href.indexOf(document.domain) > -1 or href.indexOf(':') == -1
      e.preventDefault()
      fadeTo href
