class Address < ApplicationRecord
  belongs_to :reference, polymorphic: true, optional: true
  validates :address, :zip, :city, :country, presence: true
end
