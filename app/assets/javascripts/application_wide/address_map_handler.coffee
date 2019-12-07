class AddressMapHandler

  constructor: () ->
    console.log 'inside google'
    @init_map()


  init_map: () ->
    sarajevo =
      lat: 43.84864
      lng: 18.35644

    element = $('#googleMap')

    unless element.length > 0
      return false

    map = new (google.maps.Map)(element[0],
      zoom: 15
      center: sarajevo
      )

    marker = new (google.maps.Marker)(
      position: sarajevo
      map: map)
    return

$ ->
  new AddressMapHandler
