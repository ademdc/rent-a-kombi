class AddressMapHandler

  constructor: () ->
    console.log 'inside google'
    @init_map()


  init_map: () ->
  # The location of Sarajevo
    sarajevo =
      lat: 43.84864
      lng: 18.35644

    styledMapType = new (google.maps.StyledMapType)([
      {
        elementType: 'geometry'
        stylers: [ { color: '#ebe3cd' } ]
      }
      {
        elementType: 'labels.text.fill'
        stylers: [ { color: '#523735' } ]
      }
      {
        elementType: 'labels.text.stroke'
        stylers: [ { color: '#f5f1e6' } ]
      }
      {
        featureType: 'administrative'
        elementType: 'geometry.stroke'
        stylers: [ { color: '#c9b2a6' } ]
      }
      {
        featureType: 'administrative.land_parcel'
        elementType: 'geometry.stroke'
        stylers: [ { color: '#dcd2be' } ]
      }
      {
        featureType: 'administrative.land_parcel'
        elementType: 'labels.text.fill'
        stylers: [ { color: '#ae9e90' } ]
      }
      {
        featureType: 'landscape.natural'
        elementType: 'geometry'
        stylers: [ { color: '#dfd2ae' } ]
      }
      {
        featureType: 'poi'
        elementType: 'geometry'
        stylers: [ { color: '#dfd2ae' } ]
      }
      {
        featureType: 'poi'
        elementType: 'labels.text.fill'
        stylers: [ { color: '#93817c' } ]
      }
      {
        featureType: 'poi.park'
        elementType: 'geometry.fill'
        stylers: [ { color: '#a5b076' } ]
      }
      {
        featureType: 'poi.park'
        elementType: 'labels.text.fill'
        stylers: [ { color: '#447530' } ]
      }
      {
        featureType: 'road'
        elementType: 'geometry'
        stylers: [ { color: '#f5f1e6' } ]
      }
      {
        featureType: 'road.arterial'
        elementType: 'geometry'
        stylers: [ { color: '#fdfcf8' } ]
      }
      {
        featureType: 'road.highway'
        elementType: 'geometry'
        stylers: [ { color: '#f8c967' } ]
      }
      {
        featureType: 'road.highway'
        elementType: 'geometry.stroke'
        stylers: [ { color: '#e9bc62' } ]
      }
      {
        featureType: 'road.highway.controlled_access'
        elementType: 'geometry'
        stylers: [ { color: '#e98d58' } ]
      }
      {
        featureType: 'road.highway.controlled_access'
        elementType: 'geometry.stroke'
        stylers: [ { color: '#db8555' } ]
      }
      {
        featureType: 'road.local'
        elementType: 'labels.text.fill'
        stylers: [ { color: '#806b63' } ]
      }
      {
        featureType: 'transit.line'
        elementType: 'geometry'
        stylers: [ { color: '#dfd2ae' } ]
      }
      {
        featureType: 'transit.line'
        elementType: 'labels.text.fill'
        stylers: [ { color: '#8f7d77' } ]
      }
      {
        featureType: 'transit.line'
        elementType: 'labels.text.stroke'
        stylers: [ { color: '#ebe3cd' } ]
      }
      {
        featureType: 'transit.station'
        elementType: 'geometry'
        stylers: [ { color: '#dfd2ae' } ]
      }
      {
        featureType: 'water'
        elementType: 'geometry.fill'
        stylers: [ { color: '#b9d3c2' } ]
      }
      {
        featureType: 'water'
        elementType: 'labels.text.fill'
        stylers: [ { color: '#92998d' } ]
      }
    ], name: 'Styled Map')

    # The map, centered at Sarajevo
    map = new (google.maps.Map)(document.getElementById('googleMap'),
      zoom: 15
      center: sarajevo
      )
    # The marker, positioned at Sarajevo
    marker = new (google.maps.Marker)(
      position: sarajevo
      map: map)
    return

$ ->
  new AddressMapHandler
