module ConversationsHelper
  def recipient_conversations_for(user)
    html = ''
    conversations = []
    Conversation.per_user(user.id).each do |conversation|
      if conversation.sender_id == user.id || conversation.recipient_id == user.id
        if conversation.sender_id == user.id
          recipient = User.find(conversation.recipient_id)
        else
          recipient = User.find(conversation.sender_id)
        end
          # html += (link_to recipient.email, conversation_messages_path(conversation))
          conversations << { recipient: recipient, conversation: conversation }
      end
    end
    conversations
  end

end