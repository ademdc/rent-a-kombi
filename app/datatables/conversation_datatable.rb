class ConversationDatatable
  include DatatableDSL

  set_locale_scope :conversation

  register_column :name, db_source: 'hubs.name', orderable: true, searchable: true, disable_toggling: true
  register_column :addresses_count, additional_classes: 'td-right td-120'
  register_column :action, additional_classes: 'td-center td-120', disable_toggling: true

  collection Conversation

  decorate do |record, h|
    {
      name:                      h.link_to_resource(record),
      addresses_count:           record.addresses.count,
      action:                    h.action_menu_icon(record)
    }
  end

  configure do
    ajax routes.datatables_conversations_path
    order [[0, 'desc']]
  end

end
