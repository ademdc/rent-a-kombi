class AddPriceToReservation < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :price, :float
  end
end
