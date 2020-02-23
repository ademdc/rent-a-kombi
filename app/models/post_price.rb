class PostPrice < ApplicationRecord
  belongs_to :post, dependent: :destroy
end