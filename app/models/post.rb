class Post < ApplicationRecord
  belongs_to :category
  has_one :vehicle
end
