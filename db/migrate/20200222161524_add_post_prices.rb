class AddPostPrices < ActiveRecord::Migration[5.2]
  def change
    create_table :post_prices do |t|
      t.references :post
      t.integer    :min_days
      t.integer    :max_days
      t.integer    :price

      t.timestamps
    end
  end
end
