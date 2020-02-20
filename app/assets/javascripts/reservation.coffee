class Reservations
  constructor: () ->
    @$user_icon = $('.js-user-photo-asset').data('user_icon')
    @innitialize_listeners()

  innitialize_listeners: () =>
    $(document).on 'change', '.js-guest-user-data', (e) =>
      $target = $(e.currentTarget)
      @enable_user_create($target)

    $(document).on 'click', '.js-register-guest-user', (e) =>
      e.preventDefault()
      $target = $(e.currentTarget)
      $('.loader').show()
      $('.guest-user-container-fields').hide()

      url = $target.parents('.guest-user-container').data('url')
      data = @prepare_user_data()

      $.ajax
        url: url
        data: data
        method: 'POST'
        dataType: 'JSON'
        success: (data) =>
          @handle_register_user_success(data)
        error: () =>
          @handle_register_user_error()

  enable_user_create: () =>
    $('.js-guest-user-data').each (_, input) =>
      unless $(input).val()
        $('.js-reservations-password-container').hide()
        return

    $('.js-reservations-password-container').show('flex')

  prepare_user_data: () =>
    first_name            = $('.js-guest-user-first-name').val()
    last_name             = $('.js-guest-user-last-name').val()
    email                 = $('.js-guest-user-email').val()
    phone_number          = $('.js-guest-user-phone-number').val()
    password              = $('.js-guest-user-password').val()
    password_confirmation = $('.js-guest-user-password-confirmation').val()
    locale                = $('.js-guest-user-locale').val()

    data = {
      'user[first_name]': first_name,
      'user[last_name]': last_name,
      'user[email]': email,
      'user[phone_number]': phone_number,
      'user[password]': password,
      'user[password_confirmation]': password_confirmation,
      'user[locale]': locale,
      'format': 'json'
    }

  handle_register_user_success: (data) =>
    overview_template = JST['templates/registration_user_info'](data: data)
    $('.guest-user-container').html(overview_template)

    navbar_template = JST['templates/navbar_right'](data: data, user_icon: @$user_icon)
    $('.js-navbar-right').html(navbar_template)

    $('.js-reservation-user-id').val(data.id)
    $('.js-rent').enable()
    toastr.success I18n.t('user.created')

  handle_register_user_error: (data) =>
    $('.loader').hide()
    $('.guest-user-container-fields').show()
    toastr.error I18n.t('devise.failure.email_maybe_taken')


$(document).ready ->
  reservations = new Reservations
