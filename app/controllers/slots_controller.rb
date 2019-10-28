class SlotsController < ApplicationController
  before_action :get_slot, only: [:show]


  def show
  end


  def create
    @slot = Slot.new(slot_params)

    respond_to do |format|
      if @slot.save
        format.json { render json: { message: 'Slot created successfully.' } , status: :ok }
      else
        format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  def for_post
    @slot = Slot.where(post_id: params[:post_id])
  end


  def get_slot
    @slot = Slot.find(params[:id])
  end

  protected

  def slot_params
    params.require(:slot).permit(:post_id, :start, :end)
  end
end
