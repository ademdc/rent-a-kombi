class AddressMapHandler

  constructor: () ->
    @init_map()


  init_map: () ->
    lat = parseFloat(parseFloat($('#js-latitude').val()).toFixed(5))
    lng = parseFloat(parseFloat($('#js-longitude').val()).toFixed(5))

    location =
      lat: lat
      lng: lng

    element = $('#googleMap')

    unless element.length > 0
      return false

    map = new (google.maps.Map)(element[0],
      zoom: 15
      center: location
      )

    marker = new (google.maps.Marker)(
      position: location
      map: map)
    return

$ ->
  new AddressMapHandler
