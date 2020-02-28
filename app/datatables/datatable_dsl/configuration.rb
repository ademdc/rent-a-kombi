module DatatableDSL
  class Configuration
    DEFAULT_CONFIGURATION = {
      paging:        true,
      server_side:   true,
      fixed_header:  false,
      page_length:   25,
      auto_width:    false,
      a_length_menu: [25, 50, 100],
      order:         [[0, 'asc']],
      language: {
        search: I18n.t('buttons.search'),
        lengthMenu: I18n.t('message.datatable.sLengthMenu_label', { menu: '_MENU_' }),
        info: I18n.t('message.datatable.sInfo_label', { start: '_START_', end: '_END_', total: '_TOTAL_' }),
        infoEmpty: I18n.t('message.datatable.empty_label'),
        emptyTable: I18n.t('message.datatable.emptyTable_label'),
        infoFiltered: "(Filtrirano od _MAX_ ukupnih records)"
      }
    }.freeze

    def initialize(columns)
      @configuration = DEFAULT_CONFIGURATION.deep_dup
      @configuration[:columns] = columns
    end

    def method_missing(name, *args, &block)
      @configuration[name] = args[0]
    end

    def get
      @configuration
    end

    def routes
      Rails.application.routes.url_helpers
    end
  end
end
