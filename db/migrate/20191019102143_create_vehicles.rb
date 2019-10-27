class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.string :model
      t.string :string
      t.integer :production_year
      t.string :gas_type
      t.integer :milage
      t.references :post

      t.timestamps
    end
  end
end
