module WithAddresses
  extend ActiveSupport::Concern

  COUNTRY_NAME_BOSNIA = 'Bosnia and Herzegovina'

  included do
    has_one :address, as: :reference #, inverse_of: :reference
    scope :by_city, ->(city) { joins(:addresses).where(addresses: { city: city }) }

    accepts_nested_attributes_for :address, allow_destroy: true, reject_if: :all_blank
  end

  def is_geocoded?
    self.latitude && self.longitude
  end

end
