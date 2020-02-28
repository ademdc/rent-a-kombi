class AddDefaultPurchaseItems < ActiveRecord::DataMigration
  def up
    PurchaseItem.where(title: '10 ducats', ducats: 10, price_cents: 1000).first_or_create
    PurchaseItem.where(title: '50 ducats', ducats: 50, price_cents: 4000).first_or_create
    PurchaseItem.where(title: '100 ducats', ducats: 150, price_cents: 7000).first_or_create
    PurchaseItem.where(title: '250 ducats', ducats: 250, price_cents: 15000).first_or_create
    PurchaseItem.where(title: '500 ducats', ducats: 750, price_cents: 25000).first_or_create
    PurchaseItem.where(title: '750 ducats', ducats: 750, price_cents: 30000).first_or_create
  end
end