class Slot < ApplicationRecord
  belongs_to :post
  scope :for_post, -> (post_id) { where(post_id: post_id) }

  def between_range?(from, to)
    self.start.between?(from, to) || self.end.between?(from, to)
  end
end
