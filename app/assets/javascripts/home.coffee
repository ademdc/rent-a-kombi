class Home
  constructor: () ->
    @innitialize_plugins()

  innitialize_plugins: () ->
    @innitialize_daterangepicker()
    @innitialize_flexslider()

  innitialize_daterangepicker: () ->
    $('.daterange').daterangepicker
      locale: format: 'D/M/YYYY hh:mm'

  innitialize_flexslider: () ->
    $('.flexslider').flexslider()

$(document).ready ->
  home = new Home
