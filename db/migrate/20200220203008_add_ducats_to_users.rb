class AddDucatsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :ducats, :integer, default: 30
    add_index :users, :ducats
  end
end
