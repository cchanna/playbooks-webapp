fadeOut = (after) ->
  console.log 'fade out'
  $('#slider').animate {opacity: 0}, 300, ->
    if after?
      after()

@load = (data) ->
  console.log 'load'
  $('#slider').html(data)

@fadeIn = (after) ->
  console.log 'fade in'
  $('#slider').animate {opacity: 1}, 300, ->
    if after?
      after()

@slideTo = (url, quiet) ->
  console.log 'slide to ' + url
  fadeOut ->
    $.ajax(url: url, dataType: "script").complete (data, status) =>
      console.log 'ajax:' + status
      unless status == "success"
        # a failure means that we got back html, not javascript
        # so we just render it instead
        unless quiet?
          console.log 'push state ' + url
          history.pushState {}, '', url
        load data.responseText
        fadeIn()

$ ->
  $(window).on 'popstate', (e) ->
    console.log '\nPOPSTATE'
    if e.originalEvent.state != null
      # chrome and ie insert useless popstate calls, so we want to avoid those
      e.preventDefault()
      slideTo location.pathname, true
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
    slideTo here, true
