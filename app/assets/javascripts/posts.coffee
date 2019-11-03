class Posts
  constructor: () ->
    @$calendar = $('#calendar')
    @innitialize_listeners()
    Posts.innitialize_full_calendar()

  innitialize_listeners: () ->
    $(document).on 'click', '.js-generate-slot', (e) =>
      e.preventDefault()
      return if $('.daterange').val() == ''

      $post_id = $('#calendar').data('post-id')
      start = $('.daterange').val().split('-')[0]
      end = $('.daterange').val().split('-')[1]
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
          $('#new_slot').val('')
          $('#title').val('')
        error: () =>
          toastr.error('Error occured')

    $(document).on 'click', '.js-refetch-slot', (e) =>
      e.preventDefault()
      events = [ { title  : 'event1', start  : '2019-10-06', end:  '2019-10-10 01:00' } ]
      $("#calendar").fullCalendar('addEventSource', events);
      $("#calendar").fullCalendar('refetchEvents');

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
