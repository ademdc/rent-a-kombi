class Message < ActiveRecord::Base
  include DateTimeHelper

 belongs_to :conversation
 belongs_to :user
 belongs_to :post, optional: true

 validates_presence_of :body, :conversation_id, :user_id

  def message_time
    message_datetime(created_at)
  end
end