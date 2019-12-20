class ProfileController < ApplicationController
  before_action :authenticate_user!

  def index
    @outgoing_reservations = Reservation.outgoing_reservation_for(current_user)
    @incoming_reservations = Reservation.incoming_reservation_for(current_user)
  end
end
