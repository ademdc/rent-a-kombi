class Profile
  constructor: () ->
    @init_listeners()

  init_listeners: () ->
    $(document).on 'click', '.js-delete-favorite-post', (e) =>
      e.preventDefault()
      $target = $(e.currentTarget)
      $parent = $target.parents('.favorite-posts')

      url = $parent .data('delete-url')
      post_id = $parent.data('post-id')

      $.ajax
        url: url
        method: 'DELETE'
        data: { 'favorite_post_id': post_id }
        dataType: 'JSON'
        success: (data) =>
          toastr.success I18n.t('profile.removed_favorite')
          $parent.fadeOut('slow')
        error: (data) =>
          toastr.error I18n.t('profile.error')


    $(document).on 'click', '.js-confirm-reservation', (e) =>
      $target   = $(e.currentTarget)

      $parent      = $target.parents('.incoming-reservation')
      post_title   = $parent.data('post-title')
      user_name    = $parent.data('user-name')
      ducat_price  = $parent.data('ducat-price')

      swal {
        title: I18n.t('profile.confirm_reservation', { user_name: user_name, post_title: post_title })
        text:  "Ova rezervacija ce vas kostati #{ducat_price} dukata"
        type: 'info'
        showCancelButton: true
        confirmButtonColor: '#DD6B55'
        confirmButtonText: I18n.t('profile.confirm?')
        cancelButtonText: I18n.t('profile.cancel')
        closeOnConfirm: yes
      }, =>
          @confirm_reservation($target)

    $(document).on 'click', '.js-delete-reservation', (e) =>
      $target   = $(e.currentTarget)
      swal {
        title: I18n.t('profile.delete_reservation')
        type: 'info'
        showCancelButton: true
        confirmButtonColor: '#DD6B55'
        confirmButtonText: I18n.t('profile.confirm?')
        cancelButtonText: I18n.t('profile.cancel')
        closeOnConfirm: yes
      }, =>
          @delete_reservation($target)

  confirm_reservation: ($target) =>
    $parent           = $target.parents('.incoming-reservation')
    reservation_url   = $parent.data('reservation-url')
    reservation_id    = $parent.data('reservation-id')

    $.ajax
      url: reservation_url
      method: 'POST'
      data: { 'reservation[id]': reservation_id, 'id': reservation_id}
      dataType: 'JSON'
      success: (data) =>
        toastr.success data.message
        @handle_reservation_confirm($target)
      error: (data) =>
        console.log data
        toastr.error data.responseJSON.message

  delete_reservation: ($target) ->
    $parent   = $target.parents('.incoming-reservation')
    reservation_url = $parent.data('reservation-url')
    reservation_id  = $parent.data('reservation-id')

    $.ajax
      url: reservation_url
      method: 'DELETE'
      data: { 'id': reservation_id, 'format': 'json' }
      dataType: 'JSON'
      success: (data) =>
        @handle_reservation_delete($parent, data)
      error: (data) =>
        toastr.error data.responseText

  handle_reservation_confirm: ($target) ->
    $target.addClass('hidden')
    $target.parents('.incoming-reservation').find('.js-reservation-info').addClass('hidden')
    $target.parents('p').append('True')

  handle_reservation_delete: ($target, data) ->
    toastr.success data.message
    $target.fadeOut('slow')

$(document).ready ->
  search = new Profile
