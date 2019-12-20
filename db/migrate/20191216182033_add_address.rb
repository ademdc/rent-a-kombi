class AddAddress < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |a|
      a.string :address
      a.string :city
      a.string :country
      a.string :zip
      a.string :street_number
      a.float :latitude
      a.float :longitude

      a.integer :reference_id
      a.string  :reference_type
    end
  end
end
