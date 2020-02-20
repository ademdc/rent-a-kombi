$.fn.extend({
  id: () ->
    this.attr('id')

  exists: () ->
    this.length > 0

  hide: () ->
    $(this).addClass('hidden')

  show: (display='block') ->
    $(this).removeClass('hidden').css('display', display)

  toggle_conditional: (visible, display='block') ->
    if visible
      $(this).gazzda_show(display)
    else
      $(this).gazzda_hide(display)

  toggle: () ->
    if $(this).hasClass('hidden')
      $(this).show()
    else
      $(this).hide()

  disable: () ->
    @.each () ->
      $el = $(@)
      $el.prop('disabled', true).addClass('disabled')

  enable: () ->
    @.each () ->
      $el = $(@)
      $el.prop('disabled', false).removeClass('disabled')

  automatic_select: () ->
    $el = $(@)
    if $el.find('option').length < 3
      $el.find('option:last').attr('selected', true)
      $el.trigger('change')

  trigger_multiple: (list) ->
    @each ->
      $this = $(this)
      $.each list.split(' '), (k, v) ->
        $this.trigger v
        return
      return
});
