init = ->
  here = location.pathname
  console.log("\nINIT: " + here)

  if $('#slider').html().trim() == ""
    console.log('empty frame')
    # fadeTo here
    fade()
    return

  if here == Routes.new_character_path()
    console.log("new character path")
    submitButton = '#new-character-form #submit-button'
    $('.new-character-form-radio').click ->
      console.log("click radio")
      $(submitButton).css(display: 'inline')
      $(submitButton).animate {opacity: 1, duration: 300}
    $('#new-character-form').on 'ajax:success', (e,data,status,xhr) ->
      console.log('ajax: success')
      fadeTo data

# $.fn.extend
slideTo = (data) ->
  # return @each () ->
  console.log('slide')
  # console.log('#slider')
  # console.log(data)
  $('#slider').animate {opacity: 0}, 300, ->
    $('#slider').html(data)
    # console.log($('#slider').html())
    init()
    $('#slider').animate(opacity: 1, duration: 300)

fade = ->
  console.log('fade')
  $.ajax(url: location.pathname, dataType: "script").always (data) =>
    # $('#slider').slideTo data.responseText
    slideTo data.responseText

fadeTo = (url) ->
  console.log('fade to ' + url)
  $.ajax(url: url, dataType: "script").always (data) =>
    console.log('pushState ' + url)
    history.pushState {}, '', url
    # $('#slider').slideTo data.responseText
    slideTo data.responseText

fadeBackTo = (url) ->
  console.log('fade back to ' + url)
  $.ajax(url: url, dataType: "script").always (data) =>
    # $('#slider').slideTo data.responseText
    slideTo data.responseText



$ ->
  $(window).on 'popstate', (e) ->
    console.log('popstate')
    if e.originalEvent.state != null
      e.preventDefault()
      fadeBackTo location.pathname
    else
      e.preventDefault()

  $(document).on 'click', 'a.slide', (e) ->
    console.log('link click')
    href = $(this).attr('href')
    if href.indexOf(document.domain) > -1 or href.indexOf(':') == -1
      e.preventDefault()
      fadeTo href
  init()
  # $(document).on 'click', '#slider input[type=submit]', (e) ->
    # e.preventDefault()
    # console.log "hello"
