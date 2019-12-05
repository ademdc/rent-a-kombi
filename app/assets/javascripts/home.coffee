class Home
  constructor: () ->
    @innitialize_plugins()

  innitialize_plugins: () ->
    @innitialize_daterangepicker()
    @innitialize_flexslider()

  innitialize_daterangepicker: () ->
    # $('.daterange').daterangepicker
    #   locale: format: 'D/M/YYYY hh:mm'
    $('.daterange').flatpickr
      enableTime: true
      minDate: 'today'
      time_24hr: true
      dateFormat: 'd/m/Y H:i'
      locale:
        firstDayOfWeek: 1



  innitialize_flexslider: () ->
    $('.flexslider').flexslider()

$(document).ready ->
  home = new Home
