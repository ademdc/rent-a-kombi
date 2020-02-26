class AddPurchaseAndPurchaseItems < ActiveRecord::Migration[5.2]
  def change

    create_table :purchase_items do |t|
      t.string      :title

      t.timestamps
    end

    add_monetize :purchase_items, :price, currency: { present: true, default: 'BAM' }
  end

  create_table :purchases do |t|
      t.references  :user
      t.references  :purchase_item
      t.integer     :status, default: 0
      t.string      :title
      t.string      :token
      t.string      :charge_id
      t.string      :error_message
      t.string      :payment_gateway

      t.timestamps
    end

end
