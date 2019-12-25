class Profile
  constructor: () ->
    @init_listeners()

  init_listeners: () ->

    $(document).on 'click', '.js-confirm-reservation', (e) =>
      $target   = $(e.currentTarget)

      $parent    = $target.parents('.incoming-reservation')
      url        = $parent.data('url')
      post_id    = $parent.data('post-id')
      post_title = $parent.data('post-title')
      user_name  = $parent.data('user-name')
      start      = $parent.data('reservation-start')
      end        = $parent.data('reservation-end')

      swal {
        title: "Confirm reservation to #{user_name} for post #{post_title}?"
        text: 'Confirm?'
        type: 'info'
        showCancelButton: true
        confirmButtonColor: '#DD6B55'
        confirmButtonText: 'Confirm'
        closeOnConfirm: yes
      }, =>
            $.ajax
              url: url
              method: 'POST'
              data: { 'slot[post_id]': post_id, 'slot[title]': user_name, 'slot[start]': start, 'slot[end]': end }
              dataType: 'JSON'
              success: (data) =>
                toastr.success data.message
                @confirm_reservation($target)
              error: (data) =>
                toastr.error data.responseJSON.message.base

  handle_reservation_update: ($target) ->
    $target.addClass('hidden')
    $target.parents('.incoming-reservation').find('.js-reservation-info').css('hidden')
    $target.parents('p').append('True')

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
        toastr.error data.responseText



$(document).ready ->
  search = new Profile
