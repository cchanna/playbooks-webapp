$ ->
  jQuery.fn.extend disable: (state) ->
    @each ->
      $this = $(this)
      if $this.is('input, button')
        @disabled = state
      else
        $this.toggleClass 'disabled', state
      return
