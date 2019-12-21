class AddressAutofillForm
  constructor: ($container) ->
    @$scope = $container
    @$autocomplete = ''
    @$componentForm =
      street_number: 'short_name'
      route: 'long_name'
      locality: 'long_name'
      country: 'long_name'
      postal_code: 'short_name'

    @init_listeners($container)
    @init_autocomplete($container)

  init_listeners: ($scope) ->
    $scope.find('.js-address-autofill').on 'focus', (e) =>
      @geolocate()

    $scope.find('.js-address-autofill').on 'keyup keypress', (e) ->
      keyCode = e.keyCode or e.which
      if keyCode == 13
        e.preventDefault()
        return false

  init_autocomplete: ($scope) =>
    $autocomplete_input = @$scope.find('.js-address-autofill')[0]

    return unless $autocomplete_input

    @$autocomplete = new google.maps.places.Autocomplete($autocomplete_input, types: [ 'geocode' ])
    @$autocomplete.setFields([ 'address_component', 'geometry' ])

    @$autocomplete.addListener('place_changed', @fill_in_address)

  fill_in_address: () =>
    place = @$autocomplete.getPlace()

    for component of @$componentForm
      @$scope.find("##{component}").val('')
      @$scope.find("##{component}").removeAttr('disabled')

    i = 0
    while i < place.address_components.length
      addressType = place.address_components[i].types[0]
      if @$componentForm[addressType]
        val = place.address_components[i][@$componentForm[addressType]]
        @$scope.find("##{addressType}").val(val)
        @$scope.find("##{addressType}").trigger_multiple('change keyup')
      i++

    @$scope.find('.js-latitude').val(place.geometry.location.lat())
    @$scope.find('.js-longitude').val(place.geometry.location.lng())

  geolocate: () =>
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (position) =>
        geolocation =
          lat: position.coords.latitude
          lng: position.coords.longitude
        circle = new (google.maps.Circle)(
          center: geolocation
          radius: position.coords.accuracy)
        @$autocomplete.setBounds circle.getBounds()


$(document).ready ->
  new AddressAutofillForm($('.post-form-container'))
  new AddressAutofillForm($('.edit-user-container'))
  new AddressAutofillForm($('#booking'))
  new AddressAutofillForm($('.filters-search'))

