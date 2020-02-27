class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :prepare_data, only: [:create_paypal_payment]

  def submit
    @purchase = Payments::Paypal.finish(purchase_params[:charge_id])

    respond_to do |format|
      if @purchase
        format.html { redirect_to ducats_path, notice: t('purchase.success') }
      else
        format.html { redirect_to ducats_path, alert: t('purchase.error') }
      end
    end
  end

  def create_paypal_payment
    result = Payments::Paypal.create_payment(purchase: @purchase)
    if result
      render json: { token: result }, status: :ok
    else
      render json: { error: t('purchase.error') }, status: :unprocessable_entity
    end
  end

  def execute_paypal_payment
    if Payments::Paypal.execute_payment(payment_id: params[:paymentID], payer_id: params[:payerID], current_user_id: current_user.id)
      render json: {}, status: :ok
    else
      render json: { error: t('purchase.error') }, status: :unprocessable_entity
    end
  end

  private

    def purchase_params
      params.require(:purchase).permit(
        :purchase_item_id,
        :title,
        :status,
        :user_id,
        :token,
        :charge_id,
        :payment_gateway,
        :error_message)
    end

    def prepare_data
      @purchase = Purchase.new(purchase_params)
    end
end
