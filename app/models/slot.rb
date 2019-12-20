class Slot < ApplicationRecord
  belongs_to :post
  scope :for_post, -> (post_id) { where(post_id: post_id) }

  def between_range?(from, to)
    (from..to).include?(self.start) || (from..to).include?(self.end)
  end
end
