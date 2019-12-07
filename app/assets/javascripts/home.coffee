class Home
  constructor: () ->
    @innitialize_plugins()

  innitialize_plugins: () ->
    @innitialize_daterangepicker()
    @innitialize_flexslider()

  innitialize_daterangepicker: () ->
    $('.daterange').flatpickr
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

$(document).ready ->
  home = new Home
