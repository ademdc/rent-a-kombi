# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.Posts or= {}

class Posts
  constructor: () ->
    @innitialize_full_calendar()

  innitialize_full_calendar: () ->
    $('#calendar').fullCalendar({});


$ ->
  posts = new Posts
