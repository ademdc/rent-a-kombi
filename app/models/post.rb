class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_one :vehicle, dependent: :destroy
  has_many :slots, dependent: :destroy

  has_many_attached :images
  accepts_nested_attributes_for :vehicle, reject_if: :all_blank

  scope :all_except, -> (ids) { where.not(id: ids) }
end
