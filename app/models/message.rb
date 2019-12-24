class Message < ActiveRecord::Base
  include DateTimeHelper

 belongs_to :conversation
 belongs_to :user
 belongs_to :post, optional: true

 validates_presence_of :body, :conversation_id, :user_id

  def message_time
    message_datetime(created_at)
  end

  def sender
    user
  end

  def receiver
    if user.id == conversation.sender_id
      User.find(conversation.recipient_id)
    else user.id == conversation.recipient_id
      User.find(conversation.sender_id)
    end
  end
end
