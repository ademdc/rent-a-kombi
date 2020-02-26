class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :prepare_data, only: [:index]

  def create
    @purchase = Purchase.new(purchase_params)

    respond_to do |format|
      if @purchase.save
        format.html { redirect_to ducats_path, notice: t('purchase.success') }
      else
        format.html { redirect_to ducats_path, alert: t('purchase.error') }
      end
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
end
