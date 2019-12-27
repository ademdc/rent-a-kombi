class Profile
  constructor: () ->
    @init_listeners()

  init_listeners: () ->
    $(document).on 'click', '.js-confirm-reservation', (e) =>
      $target   = $(e.currentTarget)

      $parent    = $target.parents('.incoming-reservation')
      post_title = $parent.data('post-title')
      user_name  = $parent.data('user-name')

      swal {
        title: "Confirm reservation to #{user_name} for post #{post_title}?"
        text: 'Confirm?'
        type: 'info'
        showCancelButton: true
        confirmButtonColor: '#DD6B55'
        confirmButtonText: 'Confirm'
        closeOnConfirm: yes
      }, =>
          @confirm_reservation($target)

    $(document).on 'click', '.js-delete-reservation', (e) =>
      $target   = $(e.currentTarget)
      swal {
        title: "Delete reservation?"
        type: 'info'
        showCancelButton: true
        confirmButtonColor: '#DD6B55'
        confirmButtonText: 'Confirm'
        closeOnConfirm: yes
      }, =>
          @delete_reservation($target)

  confirm_reservation: ($target) =>
    $parent         = $target.parents('.incoming-reservation')
    reservation_url = $parent.data('reservation-url')
    reservation_id  = $parent.data('reservation-id')

    $.ajax
      url: reservation_url
      method: 'PATCH'
      data: { 'reservation[confirmed]': true, 'id': reservation_id}
      dataType: 'JSON'
      success: (data) =>
        toastr.success data.message
        @handle_reservation_update($target)
      error: (data) =>
        console.log data
        toastr.error data.responseJSON.message.base

  delete_reservation: ($target) ->
    $parent   = $target.parents('.incoming-reservation')
    reservation_url = $parent.data('reservation-url')
    reservation_id  = $parent.data('reservation-id')

    $.ajax
      url: reservation_url
      method: 'DELETE'
      data: { 'id': reservation_id }
      dataType: 'JSON'
      success: (data) =>
        @handle_reservation_delete($parent, data)
      error: (data) =>
        toastr.error data.responseText

  handle_reservation_update: ($target) ->
    $target.addClass('hidden')
    $target.parents('.incoming-reservation').find('.js-reservation-info').addClass('hidden')
    $target.parents('p').append('True')

  handle_reservation_delete: ($target, data) ->
    toastr.success data.message
    $target.fadeOut('slow')

$(document).ready ->
  search = new Profile
