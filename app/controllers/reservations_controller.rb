class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:edit, :destroy]

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      respond do |format|
        format.html { redirect_to posts_path, notice: 'Reservation succesfully created' }
      end
    else
      format.json { render json: @post.errors, status: :unprocessable_entity }
    end
  end

  def edit
  end

  def destroy
  end

  private

    def reservation_params
      params.require(:reservation).permit(
        :post_id,
        :user_id,
        :start,
        :end,
        :confirmed)
    end

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end
end
