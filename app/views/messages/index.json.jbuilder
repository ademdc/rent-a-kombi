json.array! @messages do |msg|
  json.id msg.id
  if msg.post.present?
    json.post do |post|
      json.id msg.post.id
      json.url post_path(msg.post)
      json.title msg.post.title
    end
  end
  json.body msg.body
  json.user_id msg.user_id
  json.conversation do |conversation|
    json.id msg.conversation_id
    json.url conversation_messages_path(msg.conversation_id)
    json.recipient msg.conversation.recipient_of(current_user).full_name
    json.recipient_id msg.conversation.recipient_of(current_user).id
    json.recipient_slug msg.conversation.recipient_of(current_user).slug
  end
  json.created_at msg.message_time
  json.current_user_id current_user.id
  json.receiver_name
end