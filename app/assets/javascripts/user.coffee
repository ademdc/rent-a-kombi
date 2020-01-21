class User
  constructor: () ->
    @innitialize_listeners()

  innitialize_listeners: () ->
    $(document).on 'click', '.js-change-password', (e) =>
      e.preventDefault()

    $(document).on 'click', '.js-update-user', (e) =>
      e.preventDefault()

    $(document).on 'keyup keypress', '.js-current-password', (e) ->
      keyCode = e.keyCode or e.which
      if keyCode == 13
        e.preventDefault()
        $('.js-confirm-password-button').trigger('click')

    $('input[autocomplete="off"]').each ->
      $(@).val('')


$(document).ready ->
  user = new User
