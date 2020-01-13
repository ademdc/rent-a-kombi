class FavoritePost < ApplicationRecord
  belongs_to :user
  belongs_to :post

  scope :by_user, -> (user) { where(user_id: user.id) }
end
