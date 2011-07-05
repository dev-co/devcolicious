hide_flash_message = ->
  flash = $( '#flash' )
  if flash
    flash.delay( 3000 ).slideUp 'slow'

$( document ).ready ->
  $( 'a.ajax-content' ).colorbox()
  hide_flash_message()
