class AddAttributesToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :model, :integer
    add_column :posts, :production_year, :integer
    add_column :posts, :fuel, :integer, default: 0
    add_column :posts, :milage, :integer
    add_column :posts, :transmission, :integer, default: 0
    add_column :posts, :price, :integer
    add_column :posts, :number_of_seats, :integer
    add_column :posts, :hp, :integer
    add_column :posts, :kw, :string
  end
end
