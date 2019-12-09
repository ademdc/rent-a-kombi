class Reservation < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :user_id, :post_id, :start, :end, presence: true

  validate :same_user?

  private

    def same_user?
      return true if self.user_id == self.post.user.id
      false
    end
end
