class SlotsController < ApplicationController
  before_action :get_slot, only: [:show, :destroy]


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
    @slot.destroy
    respond_to do |format|
      format.json { head :no_content, notice: 'Deleted' }
    end
  end

  def for_post
    @slots = Slot.for_post(params[:post_id])
    respond_to do |format|
      format.json { render json: @slots , status: :ok }
    end
  end

  def last_slot
    @slot = Slot.where(post_id: params[:post_id]).last

    respond_to do |format|
      format.json { render json: @slot , status: :ok }
    end
  end


  def get_slot
    @slot = Slot.find(params[:id])
  end

  protected

  def slot_params
    params.require(:slot).permit(:post_id, :start, :end, :title)
  end
end
