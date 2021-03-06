class AddressMapHandler

  constructor: () ->
    @init_map()
    @init_search_map()


  init_map: () ->
    lat = parseFloat(parseFloat($('#js-latitude').val()).toFixed(5))
    lng = parseFloat(parseFloat($('#js-longitude').val()).toFixed(5))

    location =
      lat: lat
      lng: lng

    element = $('#googleMap')

    unless element.length > 0 and (lat && lng)
      return false

    map = new (google.maps.Map)(element[0],
      zoom: 15
      center: location
      )

    marker = new (google.maps.Marker)(
      position: location
      map: map)
    return

  init_search_map: () =>
    map_data = []
    @$car_icon = $('.js-address-assets').data('car_icon')
    $('.post-data').each (index, coordinate) =>

      map_data.push({
        coordinates:
          lat: $(coordinate).data('latitude')
          lng: $(coordinate).data('longitude')
        title: $(coordinate).data('title')
        post_id: $(coordinate).data('post-id')
        })

    element = $('#searchMap')
    lat = element.data('latitude')
    lng = element.data('longitude')

    zoom = 12

    unless lat && lng
      lat = 43.8131
      lng = 18.4233
      zoom = 7.5

    unless element.length > 0
      return false

    map = new (google.maps.Map)(element[0],
      zoom: zoom
      center: { lat: lat, lng: lng }
      )

    markers = map_data.map((data, i) =>
      marker = new (google.maps.Marker)(
        position: data.coordinates
        icon: @$car_icon
      )

      infoWindow = new (google.maps.InfoWindow)(
        content: "<p>#{data.title}</p> <p style='font-size: 9px;'>Click on icon to focus</p>"
      )

      marker.addListener 'click', ->
        $('html, body').animate({ scrollTop: $("[data-post-id=#{data.post_id}]").offset().top }, 'slow')
        $parent = $("[data-post-id=#{data.post_id}]").parents('.list-group-item')

        $parent.addClass('scaled')

        window.setTimeout (->
          $parent.removeClass 'scaled'
          return
        ), 1500


      marker.addListener 'mouseover', ->
        infoWindow.open map, marker

      marker.addListener 'mouseout', ->
        infoWindow.close map, marker

      return marker
    )

    markerCluster = new MarkerClusterer(map, markers, imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m')


$ ->
  new AddressMapHandler
