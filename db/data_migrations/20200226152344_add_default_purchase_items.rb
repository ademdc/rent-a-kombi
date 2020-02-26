class AddDefaultPurchaseItems < ActiveRecord::DataMigration
  def up
    PurchaseItem.where(title: '100 ducats',  price_cents: 10000).first_or_create
    PurchaseItem.where(title: '250 ducats',  price_cents: 20000).first_or_create
    PurchaseItem.where(title: '750 ducats',  price_cents: 50000).first_or_create
  end
end