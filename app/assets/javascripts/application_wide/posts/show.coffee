class Show
  constructor: () ->
    @bounce_button()
    @initilize_listeners()

  initilize_listeners: () ->
    $(document).on 'click', '.js-check-availability', (e) =>
      e.preventDefault()

      from = $('.picker-from').val()
      to = $('.picker-to').val()

      unless from && to
        toastr.warning I18n.t('post.enter_date')
        $('.picker-from').focus()
        return

      url = $(e.currentTarget).parents('.subtitle-container').data('post-available-url')

      $.ajax
        url: url
        data: { available_from: from, available_to: to }
        method: 'POST'
        dataType: 'JSON'
        success: (data) =>
          if data == true
            $('.js-available').removeClass('hidden')
            $('.js-not-available').addClass('hidden')
            @bounce($('.js-available'))
          else
            $('.js-not-available').removeClass('hidden')
            $('.js-available').addClass('hidden')
            @bounce($('.js-not-available'))

        error: () =>
          console.log I18n.t('error')

  bounce_button: () ->
    $to_bounce = if @hidden($('.js-available')) then $('.js-check-availability') else  $('.btn-reserve')

    setTimeout =>
      @bounce($to_bounce)
    , 2000

  bounce: ($element) ->
    $element.effect('bounce', { times: 2 }, 'slow')

  hidden: ($element) ->
    $element.hasClass('hidden')

$(document).ready ->
  new Show()


