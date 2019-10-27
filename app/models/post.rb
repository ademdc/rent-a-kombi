class Post < ApplicationRecord
  belongs_to :category
  has_one :vehicle, dependent: :destroy

  has_many_attached :images
  accepts_nested_attributes_for :vehicle, reject_if: :all_blank
end
