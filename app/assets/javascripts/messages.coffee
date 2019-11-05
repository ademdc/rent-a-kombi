class Messages
  constructor: () ->
    @innitialize_listeners()

  innitialize_listeners: () ->
    $(document).on 'click', '.js-send-message', (e) =>
      e.preventDefault()

      conversation_url = $('.messaging').data('conversation-url')
      message = $('.js-message').val()
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



$(document).ready ->
  messages = new Messages
