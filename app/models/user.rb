class User < ApplicationRecord
  include WithAddresses
  extend FriendlyId

  friendly_id :full_name, use: :slugged

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :posts, dependent: :destroy
  has_many :conversations, ->(user) { unscope(:where).where("recipient_id = :id OR sender_id = :id", id: user.id) }
  has_many :messages, through: :conversations
  has_many :favorite_posts, dependent: :destroy
  has_many :reservations
  has_many :purchases

  has_one_attached :avatar

  after_update :changed_locale?

  INNITIAL_DUCATS_COUNT = 30

  def admin?
    is_admin
  end

  def my_post?(post)
    self.id==post.user.id
  end

  def in_conversation?(conversation)
    [conversation.recipient_id, conversation.sender_id].include?(self.id)
  end

  def full_name
    first_name && last_name ? "#{first_name} #{last_name}" : email
  end

  def ability
    @ability ||= Ability.new(self)
  end

  def unread_messages
    self.messages.where('user_id != ?', self.id).where(read: false).group_by(&:conversation_id).count
  end

  def profile_image
    self.avatar.attached? ? self.avatar : 'user-photo.png'
  end

  def is_favorite_post?(post)
    self.favorite_posts.pluck(:post_id).include?(post.id)
  end

  def reservations_for(post)
    Reservation.current_reservation_for(self, post)
  end

  def favorite_posts
    Post.favorite_posts_for(self)
  end

  def add_ducats(ducat_number)
    current_ducat_number = self.ducats
    new_ducat_count = current_ducat_number + ducat_number.to_i
    self.update(ducats: new_ducat_count)
  end

    private

    def changed_locale?
      # self.locale ? I18n.locale = extract_locale :
      # redirect_to root_path
    end
end
