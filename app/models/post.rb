class Post < ApplicationRecord
  belongs_to :category
  has_one :vehicle, dependent: :destroy

  accepts_nested_attributes_for :vehicle, reject_if: :all_blank
end
