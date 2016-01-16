@fadeOut = (element, doFollowup) ->
  console.log 'fade out ' + element
  if $(element).css("opacity") > 0
    $(element).animate opacity: 0, 300, doFollowup
  else if doFollowup?
    doFollowup()

fadeIn = (element, doFollowup) ->
  # $(element).stop()
  if $(element).css("opacity") < 1
    $(element).animate opacity: 1, 300, doFollowup
  else if doFollowup?
    doFollowup()


@hide = (element, doFollowup) ->
  if $(element).css("display") == 'none'
    doFollowup() if doFollowup?
  else
    console.log 'hide ' + element
    fadeOut element, ->
      $(element).css display: 'none'
      doFollowup() if doFollowup?

@startFaded = (element) ->
  console.log 'start with ' + element + ' faded'
  $(element).css
    opacity: 0

@startHidden = (element) ->
  console.log 'start with ' + element + ' hidden'
  $(element).css
    display: 'none'
    opacity: 0

@show = (element, doFollowup) ->
  console.log 'show ' + element
  if $(element).css("display") == 'none'
    $(element).css display: 'initial'
  fadeIn element, doFollowup

fadeOutBody = (after) ->
  hide '#slider', after

@load = (data) ->
  console.log 'load'
  $('#slider').html(data)

@fadeInBody = (after) ->
  show '#slider', after

@pushStateTo = (url) ->
  console.log 'push state ' + url
  history.pushState {}, '', url

@slideTo = (url, quiet) ->
  console.log 'slide to ' + url
  unless quiet?
    pushStateTo url
  fadeOutBody ->
    $.ajax(url: url, dataType: "script").complete (data, status) =>
      console.log 'ajax:' + status
      unless status == "success"
        # a failure means that we got back html, not javascript
        # so we just render it instead
        load data.responseText
        fadeInBody()

@slideQuietlyTo = (url) ->
  slideTo url, true

$ ->
  $(window).on 'popstate', (e) ->
    console.log '\nPOPSTATE'
    if e.originalEvent.state != null
      # chrome and ie insert useless popstate calls, so we want to avoid those
      e.preventDefault()
      slideQuietlyTo location.pathname
    else
      e.preventDefault()

  $(document).on 'click', 'a.slide', (e) ->
    console.log('\nLINK CLICK')
    href = $(this).attr('href')
    if href.indexOf(document.domain) > -1 or href.indexOf(':') == -1
      # just in case a slide link sends us somewhere offsite
      e.preventDefault()
      slideTo href

  here = location.pathname
  if location.search?
    here += location.search
  console.log "\nINIT: " + here
  if search?
    console.log "search: " + search

  if $('#slider').html().trim() == ""
    console.log 'empty frame'
    slideQuietlyTo here
