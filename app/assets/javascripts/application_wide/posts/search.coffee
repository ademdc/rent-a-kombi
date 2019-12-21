class Search
  constructor: () ->
    @$reset_filters_button = $('.js-reset-filters')
    @$refresh_filters_button = $('.js-refresh-filter')
    @set_checked_filters()
    @initialize_listeners()


  initialize_listeners: () ->
    $(document).on 'change', '.filter-content input, .filter-content select', (e) =>
      $target = $(e.currentTarget)

      if $target.val() #&& $target.parents('.filter-card').find('.checked-filter').hasClass('hidden')
        $target.parents('.filter-card').find('.checked-filter').removeClass('hidden')
        $target.parents('.filter-card').find('.filter-title').trigger('click')
        @$reset_filters_button.removeClass('hidden')
        @focus_refresh_button()
      else
        $target.parents('.filter-card').find('.checked-filter').addClass('hidden')
        @$reset_filters_button.fadeOut('fast')
        @$reset_filters_button.addClass('hidden')

    $(document).on 'click', '.js-reset-filters', (e) =>
      e.preventDefault()

      $('.filter-content input, .filter-content select').each (index, input) =>
        $(input).val('')
        $(input).trigger('change')

        @focus_refresh_button()

  set_checked_filters: () =>
    $('.checked-filter').parents('.filter-card').find('input, select').each (index, input) =>
      if $(input).val()
        @$reset_filters_button.removeClass('hidden')
        $(input).parents('.filter-card').find('.checked-filter').removeClass('hidden')

  focus_refresh_button: () =>
    @$refresh_filters_button.addClass 'scaled'
    @$refresh_filters_button.addClass 'light-blue-bg'
    window.setTimeout (=>
      @$refresh_filters_button.removeClass 'scaled'
      @$refresh_filters_button.removeClass 'light-blue-bg'
      return
    ), 1500


$(document).ready ->
  new Search()
