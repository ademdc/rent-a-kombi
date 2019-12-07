class Posts
  constructor: () ->
    @$calendar = $('#calendar')
    @innitialize_listeners()
    Posts.innitialize_full_calendar()

  innitialize_listeners: () ->
    $(document).on 'click', '.js-add-favorite-post', (e) =>
      e.preventDefault()
      $target = $(e.currentTarget)

      if $target.hasClass('btn-red')
        toastr.warning 'This post is already in favorites'
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

    $(document).on 'click', '.js-generate-slot', (e) =>
      e.preventDefault()
      return if $('#slot_start').val() == ''

      $post_id = $('#calendar').data('post-id')
      start = $('#slot_start').val()
      end = $('#slot_end').val()
      title = $('.js-title').val()

      data = { 'slot[post_id]': $post_id, 'slot[start]': start, 'slot[end]': end, 'slot[title]': title }
      url = $('#calendar').data('slot-url')

      $.ajax
        url: url
        data: data
        method: 'POST'
        dataType: 'JSON'
        success: (data) =>
          toastr.success('New time slot successfully created')
          Posts.refresh_calendar()
          $('#slot_start').val('')
          $('#slot_end').val('')
          $('#title').val('')
        error: () =>
          toastr.error('Error occured')

    $(document).on 'click', '.js-refetch-slot', (e) =>
      e.preventDefault()
      events = [ { title  : 'event1', start  : '2019-10-06', end:  '2019-10-10 01:00' } ]
      $("#calendar").fullCalendar('addEventSource', events);
      $("#calendar").fullCalendar('refetchEvents');

    $(document).on 'click', '.js-check-availability', (e) ->
      from = $('input[name="available_from"]').val()
      to = $('input[name="available_to"]').val()
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
              Posts.slot_delete(event, element)
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

  @slot_delete: (event, element) =>
    swal {
      title: 'Do you really want to delete time slot?'
      text: 'Delete?'
      type: 'warning'
      showCancelButton: true
      confirmButtonColor: '#DD6B55'
      confirmButtonText: 'Delete'
      closeOnConfirm: yes
    }, ->
          url = $('#calendar').data('slot-url')
          $post_id = $('#calendar').data('post-id')
          data = { 'id': event.id}
          $.ajax
            url: url
            data: data
            method: 'DELETE'
            dataType: 'JSON'
            success: (data) =>
              toastr.success('Time slot successfully deleted')
              Posts.refresh_calendar()
            error: () =>
              toastr.error('Error occured while deleting')

$(document).ready ->
  posts = new Posts
