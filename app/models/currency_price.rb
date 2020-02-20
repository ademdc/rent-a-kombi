class CurrencyPrice < ApplicationRecord
  belongs_to :user
  belongs_to :post

  scope :by_post, -> (post) { where(post_id: post.id) }
end
