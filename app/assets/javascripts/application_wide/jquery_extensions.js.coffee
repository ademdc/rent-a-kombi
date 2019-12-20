$.fn.id = () ->
  this.attr('id')

$.fn.exists = () ->
  this.length > 0

$.fn.hide = () ->
  $(this).addClass('hidden')

$.fn.show = (display='block') ->
  $(this).removeClass('hidden').css('display', display)

$.fn.toggle_conditional = (visible, display='block') ->
  if visible
    $(this).gazzda_show(display)
  else
    $(this).gazzda_hide(display)

$.fn.toggle = () ->
  if $(this).hasClass('hidden')
    $(this).gazzda_show()
  else
    $(this).gazzda_hide()

$.fn.disable = () ->
  @.each () ->
    $el = $(@)
    $el.prop('disabled', true).addClass('disabled')

$.fn.enable = () ->
  @.each () ->
    $el = $(@)
    $el.prop('disabled', false).removeClass('disabled')

$.fn.automatic_select = () ->
  $el = $(@)
  if $el.find('option').length < 3
    $el.find('option:last').attr('selected', true)
    $el.trigger('change')

$.fn.trigger_multiple = (list) ->
  @each ->
    $this = $(this)
    $.each list.split(' '), (k, v) ->
      $this.trigger v
      return
    return
