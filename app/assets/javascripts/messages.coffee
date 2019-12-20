class Messages
  constructor: () ->
    @innitialize_listeners()
    @innitialize_messages_pane()
    @innitialize_datatable()

  innitialize_listeners: () ->
    $('.back-to-msgs-btn').on 'click', (e) ->
      $('.messages-container').css('display', 'none')
      $('.conversation-container').css('display', 'block')

    $('.js-message').on 'click', (e) ->
      $('.messages-container').css('display', 'block')
      $('.conversation-container').css('display', 'none')

      conversation_url = $(e.currentTarget).parents('tr').data('message-url')
      $.ajax
        url: conversation_url
        method: 'GET'
        dataType: 'JSON'
        success: (data) =>
          console.log data
          Messages.render_messages(data)

        error: () =>
          toastr.error('Message could not be seen')

    $(document).on 'click', '.js-send-message', (e) =>
      e.preventDefault()

      conversation_url = $('.messaging').data('conversation-url')
      message = $('.js-message-container').val()
      current_user_id = $('.messaging').data('current-user-id')
      post_id = $('.messaging').data('post-id')

      if !message
        toastr.warning 'Enter message'
        return

      $.ajax
        url: conversation_url
        method: 'POST'
        dataType: 'JSON'
        success: (data) =>
          params = { 'conversation_id': data.id, 'message[body]': message, 'message[conversation_id]': data.id, 'message[user_id]': current_user_id, 'message[post_id]': post_id }
          $.ajax
            url: "/conversations/#{data.id}/messages.json"
            method: 'POST'
            data: params
            dataType: 'JSON'
            success: (data) =>
              toastr.success('Message sent succesfully')
              $('.modal').modal('hide')
            error: () =>
              toastr.error('Message could not be sent')
        error: () =>
          toastr.error('Error')

  @render_messages: (data) ->
    template = JST['templates/messages'](data: data)
    $('.messages-container').html(template)

  innitialize_messages_pane: () ->
    $('#myForm a').click (e) ->
      e.preventDefault()
      $(this).tab 'show'

  innitialize_datatable: () ->
    $('.datatable').DataTable(
      responsive: true,
      paging: false,
      searching: true,
      label: true,
      select: true)

    $('.dataTables_wrapper').removeClass('form-inline')


$(document).ready ->
  messages = new Messages
