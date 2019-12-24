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
    if conversation.sender_id == user.id
      User.find(conversation.sender_id)
    else
      User.find(conversation.receiver_id)
    end
  end
end
