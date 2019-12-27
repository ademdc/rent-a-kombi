class Posts
  constructor: () ->
    @$calendar = $('#calendar')
    @innitialize_listeners()
    @check_user_address()
    Posts.innitialize_full_calendar()

  innitialize_listeners: () ->
    $(document).on 'click', '.js-add-favorite-post', (e) =>
      console.log 'clicked fav'
      e.preventDefault()
      $target = $(e.currentTarget)

      if $target.hasClass('btn-red')
        toastr.warning 'This post is already in favorites'
        console.log 'in'
        return false

      url = $target.data('url')
      post_id = $target.data('post-id')
      user_id = $target.data('user-id')

      $.ajax
        url: url
        data: { post_id: post_id, user_id: user_id }
        method: 'POST'
        dataType: 'JSON'
        success: (data) =>
          toastr.success 'Post added to favorites'
          $target.addClass('btn-red')
        error: () =>
          console.log 'Error occured'

    $(document).on 'click', '.js-generate-reservation', (e) =>
      e.preventDefault()
      return if $('#reservation_start').val() == ''

      $post_id = $('#calendar').data('post-id')
      start = $('#reservation_start').val()
      end = $('#reservation_end
        ').val()
      title = $('.js-title').val()

      data = { 'reservation[post_id]': $post_id, 'reservation[start]': start, 'reservation[end]': end, 'reservation[title]': title,  'reservation[confirmed]': true }
      url = $('#calendar').data('reservation-url')

      $.ajax
        url: url
        data: data
        method: 'POST'
        dataType: 'JSON'
        success: (data) =>
          toastr.success('New reservation successfully created')
          Posts.refresh_calendar()
          $('#reservation_start').val('')
          $('#reservation_end').val('')
          $('#title').val('')
        error: () =>
          toastr.error('Error occured')

    $(document).on 'click', '.js-refetch-reservations', (e) =>
      e.preventDefault()
      Posts.refresh_calendar()

    $(document).on 'click', '.js-check-availability', (e) ->
      e.preventDefault()

      from = $('.picker-from').val()
      to = $('.picker-to').val()
      url = $(e.currentTarget).parents('.subtitle-container').data('post-available-url')

      $.ajax
        url: url
        data: { available_from: from, available_to: to }
        method: 'POST'
        dataType: 'JSON'
        success: (data) =>
          console.log data
          if data == true
            $('.available').css('display', 'inline')
            $('.not-available').css('display', 'none')
          else
            $('.not-available').css('display', 'inline')
            $('.available').css('display', 'none')

        error: () =>
          console.log 'Error with checking availability'

    $(document).on 'change', '#user_address_check', (e) =>
      $target = $(e.currentTarget)
      $container = $('.address-fields-container')
      @toggle_user_address($target, $container)

  @innitialize_full_calendar: () ->
    url = $('#calendar').data('for-posts-url')

    if url
      $.ajax
        url: url
        method: 'POST'
        dataType: 'JSON'
        success: (data) =>
          $('#calendar').fullCalendar(
            header:
              left: 'prev, next today',
              center: 'title',
              right: 'month, basicWeek, basicDay',
            events: data,
            firstDay: 1
            eventClick: (event, element) ->
              Posts.rerservation_delete(event, element)
           )
        error: () =>
          toastr.error('Error occured while loading calendar')

  @refresh_calendar: () ->
    url = $('#calendar').data('for-posts-url')
    if url
      $.ajax
        url: url
        method: 'POST'
        dataType: 'JSON'
        success: (data) =>
          $('#calendar').fullCalendar('removeEventSources');
          $("#calendar").fullCalendar('addEventSource', data);
          $("#calendar").fullCalendar('refetchEvents');
        error: () =>
          toastr.error('Error occured while loading calendar')

  @rerservation_delete: (event, element) =>
    swal {
      title: 'Do you really want to delete time reservation?'
      text: 'Delete?'
      type: 'warning'
      showCancelButton: true
      confirmButtonColor: '#DD6B55'
      confirmButtonText: 'Delete'
      closeOnConfirm: yes
    }, ->
          url = $('#calendar').data('reservation-url')
          $post_id = $('#calendar').data('post-id')
          data = { 'id': event.id}
          $.ajax
            url: url
            data: data
            method: 'DELETE'
            dataType: 'JSON'
            success: (data) =>
              toastr.success('Reservation successfully deleted')
              Posts.refresh_calendar()
            error: () =>
              toastr.error('Error occured while deleting')

  check_user_address: () =>
    $target = $('#user_address_check')
    $container = $('.address-fields-container')
    @toggle_user_address($target, $container)

  toggle_user_address: ($target, $container) =>
    if $target.is(':checked')
      $container.css('display', 'none')
      $container.find('#post_address_attributes_id').prop('disabled', 'disabled')
      $container.find('.js-latitude').prop('disabled', 'disabled')
      $container.find('.js-longitude').prop('disabled', 'disabled')
      $container.find('.js-address').prop('disabled', 'disabled')
      $container.find('.js-address-city').attr('disabled', 'disabled')
      $container.find('.js-address-zip').attr('disabled', 'disabled')
      $container.find('.js-address-country').attr('disabled', 'disabled')
      $container.find('.js-address-street-number').attr('disabled', 'disabled')
    else
      $container.css('display', 'block')
      $container.find('#post_address_attributes_id').removeAttr('disabled')
      $container.find('.js-latitude').removeAttr('disabled')
      $container.find('.js-longitude').removeAttr('disabled')
      $container.find('.js-address').removeAttr('disabled')
      $container.find('.js-address-city').removeAttr('disabled')
      $container.find('.js-address-zip').removeAttr('disabled')
      $container.find('.js-address-country').removeAttr('disabled')
      $container.find('.js-address-street-number').removeAttr('disabled')
$(document).ready ->
  posts = new Posts
