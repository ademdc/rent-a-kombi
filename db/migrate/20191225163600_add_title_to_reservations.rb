class AddTitleToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :title, :string
    add_column :reservations, :delete_at, :datetime
  end
end
