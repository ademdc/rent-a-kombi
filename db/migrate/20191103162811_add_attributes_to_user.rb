class AddAttributesToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone_number, :string
    add_column :users, :verified, :boolean, default: false
    add_column :users, :gender, :string, default: nil
    add_column :users, :city, :string
    add_column :users, :address, :string
    add_column :users, :dob, :datetime
  end
end
