@hide = (element, doFollowup) ->
  if $(element).css("display") == 'none'
    doFollowup() if doFollowup?
  else
    console.log 'hide ' + element
    $(element).animate opacity: 0, 300, ->
      $(element).css display: 'none'
      doFollowup() if doFollowup?

@startHidden = (element) ->
  console.log 'start with ' + element + ' hidden'
  $(element).css
    display: 'none'
    opacity: 0

@show = (element, doFollowup) ->
  unless $(element).css("display") == 'block'
    console.log 'show ' + element
    $(element).css display: 'initial'
    $(element).animate opacity: 1, 300, doFollowup

fadeOut = (after) ->
  hide '#slider', after

@load = (data) ->
  console.log 'load'
  $('#slider').html(data)

@fadeIn = (after) ->
  show '#slider', after

@pushStateTo = (url) ->
  console.log 'push state ' + url
  history.pushState {}, '', url

@slideTo = (url, quiet) ->
  console.log 'slide to ' + url
  unless quiet?
    pushStateTo url
  fadeOut ->
    $.ajax(url: url, dataType: "script").complete (data, status) =>
      console.log 'ajax:' + status
      unless status == "success"
        # a failure means that we got back html, not javascript
        # so we just render it instead
        load data.responseText
        fadeIn()

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
