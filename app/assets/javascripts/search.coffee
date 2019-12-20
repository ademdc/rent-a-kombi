class Search
  constructor: () ->
    @populate_fields_from_query_params()

  populate_fields_from_query_params: () ->
    urlParams = new URLSearchParams(window.location.search)
    keys = urlParams.keys()

->
  search = new Search
