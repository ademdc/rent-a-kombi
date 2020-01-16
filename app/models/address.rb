class Address < ApplicationRecord
  belongs_to :reference, polymorphic: true, optional: true
  validates :address, :zip, :city, :country, presence: true

  def full_address
    pp_join([address, city, country].compact, ', ')
  end
end
