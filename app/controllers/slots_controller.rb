class SlotsController < ApplicationController
  before_action :get_slot, only: [:show]


  def show
  end


  def create
    @slot = Slot.new(working_day_params)

    respond_to do |format|
      if @slot.save
        format.html { redirect_to @slot, notice: 'Slot was successfully created.' }
        format.json { render :show, status: :created, location: @working_day }
      else
        format.html { render :new }
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
    params.require(:slot).permit(:start, :end)
  end
end
