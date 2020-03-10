class AddDucatCountToPurchaseItems < ActiveRecord::Migration[5.2]
  def change
    add_column :purchase_items, :ducats, :integer
  end
end
