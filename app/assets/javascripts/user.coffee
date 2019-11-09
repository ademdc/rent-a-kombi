class User
  constructor: () ->
    @innitialize_listeners()

  innitialize_listeners: () ->
    $(document).on 'click', '.js-change-password', (e) =>
      e.preventDefault()

    $(document).on 'click', '.js-update-user', (e) =>
      e.preventDefault()

    $('input[autocomplete="off"]').each ->
      $(@).val('')


$(document).ready ->
  user = new User
