class Post < ApplicationRecord
  belongs_to :category
  has_one :vehicle, dependent: :destroy
  has_many :slots, dependent: :destroy

  has_many_attached :images
  accepts_nested_attributes_for :vehicle, reject_if: :all_blank

  scope :all_except, -> (ids) { where.not(id: ids) }

  def self.availability(range)
    from, to = [:availability].split('-').map(&:to_datetime)
    range = from.beginparamsning_of_day..to.end_of_day

    reserved_post_ids = Slot.where(start: range).or(Slot.where(end: range)).pluck(:post_id)
    Post.all_except(reserved_post_ids)
  end

  def
end
