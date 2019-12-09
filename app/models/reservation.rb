class Reservation < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :user_id, :post_id, :start, :end, presence: true

  validate :my_post?

  scope :current_reservation_for, ->(user, post) { where('user_id = ? AND post_id = ? AND start < ?', user.id, post.id, Time.now ) }

  def self.outgoing_reservation_for(user)
    Reservation.where(user_id: user.id)
  end

  def self.incoming_reservation_for(user)
    Reservation.includes(:post).where(posts: { user_id: user.id })
  end

  private

    def my_post?
      return false if self.user_id == self.post.user.id
      true
    end
end
