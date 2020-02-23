class Home
  constructor: () ->
    @innitialize_plugins()
    @innitialize_locale()

  innitialize_locale: () ->
    I18n.locale = $('body').data('locale')

  innitialize_plugins: () ->
    @enable_tooltip()
    @innitialize_daterangepicker()
    @innitialize_flexslider()
    @innitialize_append_nested_attributes()

  innitialize_daterangepicker: () ->
    $('.daterange').flatpickr
      # mode: 'range'
      enableTime: true
      minDate: 'today'
      time_24hr: true
      dateFormat: 'd/m/Y H:i'
      locale:
        firstDayOfWeek: 1

    $('.picker-from').on 'change', (e) ->
      $('.picker-to').trigger('focus')

    $('.picker-to').on 'change', (e) ->
      $('.picker-title').trigger('focus')

  innitialize_flexslider: () ->
    $('.flexslider').flexslider()

  enable_tooltip: () ->
    $('[data-toggle="tooltip"]').tooltip()

  innitialize_append_nested_attributes: () =>
    $('[data-form-append]').click (e) ->
      obj = $($(this).attr('data-form-append'))
      obj.find('input, select, textarea').each ->
        $(this).attr 'name', ->
          $(this).attr('name').replace 'new_record', (new Date).getTime()
        return
      obj.insertAfter this
      false


$(document).ready ->
  home = new Home
