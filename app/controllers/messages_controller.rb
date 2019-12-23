
class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action { set_up_conversation }

  def index
    @messages = @conversation.messages.includes(:post).order('created_at ASC')

    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end

    if params[:m]
      @over_ten = false
      @messages = @conversation.messages.order('created_at ASC')
    end

    if @messages.last
      if @messages.last.user_id != current_user.id
        @messages.last.update(read: true)
      end
    end

    @message = @conversation.messages.new
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)

    if @message.save
      respond_to do |format|
        format.json { render json: @conversation, status: :ok }
        format.html { redirect_to conversations_path, notice: 'Message sent succesfully'}
      end
    end
  end

  private

    def set_up_conversation
      @conversation = Conversation.find(params[:conversation_id])
      redirect_to root_path, alert: "Can not access that page" unless current_user.in_conversation?(@conversation)
    end

    def message_params
      params.require(:message).permit(:body, :user_id, :post_id)
    end
end
