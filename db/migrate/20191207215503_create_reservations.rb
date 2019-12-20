class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :user
      t.references :post
      t.datetime :start
      t.datetime :end
      t.boolean :confirmed, default: false
      t.timestamps
    end
  end
end
