class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :prepare_data, only: [:index]

  def create
    @purchase = Purchase.new(purchase_params)

    respond_to do |format|
      if @purchase.save
        format.html { redirect_to ducats_path, notice: 'Purchase was made succesfully.' }
      else
        format.html { redirect_to ducats_path, alert: 'Error occured while making payment.' }
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
