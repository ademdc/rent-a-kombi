class AddPriceToReservations < ActiveRecord::DataMigration
  def up
    Reservation.all.each { |reservation| reservation.set_price! }
  end
end