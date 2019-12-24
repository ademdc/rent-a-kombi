class Conversation < ActiveRecord::Base
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'
  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, :scope => :recipient_id

  scope :between, -> (sender_id, recipient_id) do
    where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =?)", sender_id, recipient_id, recipient_id, sender_id)
  end

  scope :per_user, -> (user_id) { includes(:messages).where('sender_id = :user_id OR recipient_id = :user_id', user_id: user_id) }

  def recipient_of(user)
    if self.sender_id == user.id || self.recipient_id == user.id
      if self.sender_id == user.id
        recipient = User.find(self.recipient_id)
      else
        recipient = User.find(self.sender_id)
      end
    end
    recipient
  end

  def has_unread_messages_for?(user)
    messages.where('user_id != ?', user.id).pluck(:read).include?(false)
  end

  def self.per_latest_message_for(current_user)
    Conversation.per_user(current_user.id).includes(:messages).order('messages.created_at ASC')
  end
end