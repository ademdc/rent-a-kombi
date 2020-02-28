class ReservationsController < ApplicationController
  before_action :authenticate_user!, except: [:create, :confirm]
  before_action :set_reservation, only: [:destroy, :update]
  after_action :set_price, only: [:create]

  def create
    @reservation = Reservation.new(reservation_params)

    respond_to do |format|
      if @reservation.save
        format.json { render json: { message: 'Reservation created successfully.' } , status: :ok }
        format.html { redirect_to profile_index_path, notice: 'Reservation succesfully created. Pending...' }
      else
        format.json { render json: { message: @reservation.errors }, status: :unprocessable_entity }
        format.html { redirect_to @reservation.post, alert: "Reservation could not be made!" }
      end
    end
  end

  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.json { render json: { message: 'Reservation updated succesfully' }, status: :ok }
      else
        format.json { render json: { message:  @reservation.errors }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reservation.destroy!

    respond_to do |format|
      format.json { render json: { message: 'Succesfully deleted reservation' } }
    end
  end

  def for_post
    @reservations = Reservation.for_post(params[:post_id])
    respond_to do |format|
      format.json { render json: @reservations, status: :ok }
    end
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
  end

  private

    def reservation_params
      params.require(:reservation).permit(
        :post_id,
        :user_id,
        :start,
        :end,
        :confirmed,
        :title)
    end

    def set_price
      @reservation.set_price!
    end

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end
end
