class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_one_attached :avatar


  def admin?
    is_admin
  end

  def my_post?(post)
    self.id==post.user.id
  end

  def in_conversation?(conversation)
    [conversation.recipient_id, conversation.sender_id].exclude?(self.id)
  end

  def full_name
    first_name && last_name ? "#{first_name} #{last_name}" : email
  end

  def ability
    @ability ||= Ability.new(self)
  end

  def profile_image
    self.avatar.attached? ? self.avatar : 'user-photo.png'
  end
end
