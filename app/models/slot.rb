class Slot < ApplicationRecord
  include PostsHelper

  belongs_to :post
  scope :for_post, -> (post_id) { where(post_id: post_id) }

  validate :does_not_have_overlaping_slots_in_same_post?

  def between_range?(from, to)
    (from..to).include?(self.start) || (from..to).include?(self.end)
  end

  protected

    def does_not_have_overlaping_slots_in_same_post?
      self.errors[:base] << 'Post is reserved for that range' if posts_with_slots_in_range_for?(self).present?
    end
end
