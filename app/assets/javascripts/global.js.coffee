hide_flash_message = ->
  flash = $( '#flash' )
  if flash
    flash.delay( 3000 ).slideUp 'slow'

center_scroll = (bookmark) ->
  viewportHeight = $(window).height()
  if window.innerHeight
    viewportHeight = window.innerHeight

  top = bookmark.offset().top - viewportHeight/2

  $('html,body').animate(scrollTop: top, 200)

$( document ).ready ->
  $( 'a.ajax-content' ).colorbox()
  hide_flash_message()

  if(first_bookmark = $( '.bookmark' ).first())
    first_bookmark.addClass("active")

  $( '.bookmark-list' ).delegate ".bookmark", "click", (ev) ->
    $( '.bookmark').removeClass("active")
    next = $(this)
    next.addClass("active")
    center_scroll(next)

  move_actived_bookmark = (ev)->
    current_bookmark = $( '.bookmark-list .bookmark.active' )
    moved = false
    next = null
    if ev.keyCode == 106
      next = current_bookmark.next()
      if  next.length > 0
        next.addClass("active")
        moved = true
    else if ev.keyCode == 107
      next = current_bookmark.prev()
      if next.length > 0
        next.addClass("active")
        moved = true

    if moved && next
      current_bookmark.removeClass("active")
      center_scroll(next)

  $( 'body' ).bind("keypress", move_actived_bookmark)
