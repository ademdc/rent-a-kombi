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

      start_date = moment(start).format("DD/MM/YYYY")
      end_date = moment(end).format("DD/MM/YYYY")

      data = { 'slot[post_id]': $post_id, 'slot[start]': start_date, 'slot[end]': end_date, 'slot[title]': title }

      url = $('#calendar').data('slot-create-url')

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
            events: data)
        error: () =>
          toastr.error('Error occured while loading calendar')


$ ->
  posts = new Posts
