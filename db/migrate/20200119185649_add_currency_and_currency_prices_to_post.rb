class AddCurrencyAndCurrencyPricesToPost < ActiveRecord::Migration[5.2]
  def change
    create_table :currencies do |t|
      t.string      :code
      t.decimal     :value
      t.string      :symbol
      t.string      :name

      t.timestamps
    end

    create_table :currency_prices do |t|
      t.references  :post
      t.references  :currency
      t.decimal     :price, default: '0.0', null: false

      t.timestamps
    end

    create_table :currencies_posts do |t|
      t.references  :post
      t.references  :currency

      t.timestamps
    end

    add_column :posts, :currency_id, :integer
  end
end
