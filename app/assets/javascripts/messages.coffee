class Messages
  constructor: () ->
    @$current_user_id = $('.js-current-user-id').val()
    @innitialize_listeners()
    @innitialize_messages_pane()
    @innitialize_datatable()

  innitialize_listeners: () ->
    $('.back-to-msgs-btn').on 'click', (e) ->
      $('.messages-container').css('display', 'none')
      $('.conversation-container').css('display', 'block')
      $('.inbox-sidebar-list').css('display', 'block')
      $(e.currentTarget).addClass('d-none')
      $('.js-receiver-name').html('')

    $(document).on 'click', '.js-message-action', (e) =>
      $('.messages-container').css('display', 'block')
      $('.conversation-container').css('display', 'none')
      $('.inbox-sidebar-list').css('display', 'none')
      $('.back-to-msgs-btn').removeClass('d-none')

      conversation_url = $(e.currentTarget).data('message-url')
      $.ajax
        url: conversation_url
        method: 'GET'
        dataType: 'JSON'
        success: (data) =>
          @render_messages(data)
          $('.js-receiver-name').html("<a href='/users/#{data[0].conversation.recipient_id}'>#{data[0].conversation.recipient}</a>")
          $('#message_body').focus()
        error: () =>
          toastr.error I18n.t('message.can_not_see')

    $(document).on 'click', '.js-send-message', (e) =>
      e.preventDefault()

      conversation_url = $('.messaging').data('conversation-url')
      message = $('.js-message-container').val()
      current_user_id = $('.messaging').data('current-user-id')
      post_id = $('.messaging').data('post-id')

      if !message
        toastr.warning(I18n.t('message.enter_message'))
        return
      # first get conversation data between current user and owner of post
      $.ajax
        url: conversation_url
        method: 'POST'
        dataType: 'JSON'
        success: (data) =>
          # Now create the message for that conversation
          params = { 'conversation_id': data.id, 'message[body]': message, 'message[conversation_id]': data.id, 'message[user_id]': current_user_id, 'message[post_id]': post_id }
          $.ajax
            url: "/conversations/#{data.id}/messages.json"
            method: 'POST'
            data: params
            dataType: 'JSON'
            success: (data) =>
              toastr.success I18n.t('message.sent')
              $('.modal').modal('hide')
            error: () =>
              toastr.error I18n.t('message.error')
        error: () =>
          toastr.error I18n.t('message.error')

  render_messages: (data) =>
    csrf_token = $('meta[name="csrf-token"]').attr('content')
    template = JST['templates/messages'](data: data, current_user_id: @$current_user_id, csrf_token: csrf_token)
    $('.messages-container').html(template)

  innitialize_messages_pane: () ->
    $('#myForm a').click (e) ->
      e.preventDefault()
      $(this).tab 'show'

  innitialize_datatable: () ->
    $('.datatable').DataTable(
      responsive: true,
      columnDefs: [
        { responsivePriority: 1, targets: 0 },
        { responsivePriority: 2, targets: -1 }
      ]
      paging: false,
      searching: true,
      label: true,
      language: {
        sSearch: I18n.t('buttons.search'),
        sLengthMenu: I18n.t('message.datatable.sLengthMenu_label', { menu: '_MENU_' })
        sInfo: I18n.t('message.datatable.sInfo_label', { start: '_START_', end: '_END_', total: '_TOTAL_' })
        sInfoEmpty: I18n.t('message.datatable.empty_label')
        emptyTable: I18n.t('message.datatable.emptyTable_label')
      }
      order: [],
      select: true)

    $('.dataTables_wrapper').removeClass('form-inline')


$(document).ready ->
  messages = new Messages
