# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.Posts or= {}

class Posts
  constructor: () ->
    @innitialize_listeners()
    @innitialize_full_calendar()

  innitialize_listeners: () ->
    $(document).on 'click', '.js-generate-slot', (e) =>
      e.preventDefault()

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
          @innitialize_full_calendar()
          toastr.success('New time slot successfully created')
        error: () =>
          toastr.error('Error occured')

  innitialize_full_calendar: () ->
    url = $('#calendar').data('generate-slots-url')
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

  @slot_delete: (event, element) ->
    if confirm("Do you really want to delete event?")
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
          $(element.currentTarget).remove()
        error: () =>
          toastr.error('Error occured while deleting')

$ ->
  posts = new Posts
