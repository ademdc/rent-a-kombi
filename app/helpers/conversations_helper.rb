module ConversationsHelper
  def recipient_conversations_for(user)
    conversations = []
    Conversation.per_user(user.id).each do |conversation|
      if conversation.sender_id == user.id || conversation.recipient_id == user.id
        if conversation.sender_id == user.id
          recipient = User.find(conversation.recipient_id)
        else
          recipient = User.find(conversation.sender_id)
        end
          messages = conversation.messages.order(:created_at)
          unread = conversation.has_unread_messages_for?(user)
          conversations << { recipient: recipient,
                             conversation: conversation,
                             unread: unread,
                             messages: messages,
                             last_message: messages.last.created_at }
      end
    end

    conversations.sort_by { |k| k[:last_message] }.reverse!
  end

end