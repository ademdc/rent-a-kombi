class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.per_user(current_user.id)
  end

  def create
   if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
   else
      @conversation = Conversation.create!(conversation_params)
   end
    respond_to do |format|
      format.json { render json: @conversation , status: :ok }
      format.html { redirect_to conversation_messages_path(@conversation) }
    end
  end

  private

   def conversation_params
    params.permit(:sender_id, :recipient_id)
   end
end