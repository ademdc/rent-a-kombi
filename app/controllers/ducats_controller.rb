class DucatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @ducat_count = current_user.ducats
  end

  def create_payment
    result = Payments::Paypal.create_payment
    if result
      render json: { token: result }, status: :ok
    else
      render json: {error: FAILURE_MESSAGE}, status: :unprocessable_entity
    end
  end

  def execute_payment
    if Payments::Paypal.execute_payment(payment_id: params[:paymentID], payer_id: params[:payerID], current_user_id: current_user.id)
      render json: {}, status: :ok
    else
      render json: {error: FAILURE_MESSAGE}, status: :unprocessable_entity
    end
  end
end