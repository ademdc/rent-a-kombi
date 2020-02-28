class Datatable
  constructor: (datatable) ->
    @$datatable = datatable
    @options = @$datatable.data('configuration')

    @initialize_datatable()

  initialize_datatable: () ->
    @datatable_object = @$datatable.DataTable(@options)


$ ->
  new Datatable($('.js-datatable table'))

