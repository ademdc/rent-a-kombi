class AddDefaultValueForPurchasePaymentGateway < ActiveRecord::Migration[5.2]
  def change
    remove_column :purchases, :payment_gateway
    add_column :purchases, :payment_gateway, :integer
  end
end
