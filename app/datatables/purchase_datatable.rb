class PurchaseDatatable
  include DatatableDSL

  set_locale_scope :purchase

  register_column :status, orderable: true, searchable: true, disable_toggling: true
  register_column :title
  register_column :payment_date

  collection Purchase

  decorate do |record, h|
    {
      status:           I18n.t("purchase.statuses.#{record.status}"),
      title:            record.title,
      payment_date:     record.formatted_date(:created_at)
    }
  end

  configure do
    ajax routes.datatables_purchases_path
    order [[0, 'desc']]
    paging false
    searching false
  end

end
