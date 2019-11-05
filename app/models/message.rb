class Message < ActiveRecord::Base
 belongs_to :conversation
 belongs_to :user
 belongs_to :post, optional: true

 validates_presence_of :body, :conversation_id, :user_id

 def message_time
  created_at.strftime("at %l:%M %p")
 end
end