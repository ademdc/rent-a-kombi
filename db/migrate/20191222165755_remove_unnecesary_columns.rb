class RemoveUnnecesaryColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :images
    remove_column :users, :city
    remove_column :users, :address

    drop_table :vehicles
  end
end
