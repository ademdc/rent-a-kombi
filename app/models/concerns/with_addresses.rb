module WithAddresses
  extend ActiveSupport::Concern

  COUNTRY_NAME_BOSNIA = 'Bosnia and Herzegovina'

  included do
    has_many :addresses, as: :reference, inverse_of: :reference
    scope :by_city, ->(city) { joins(:addresses).where(addresses: { city: city }) }

    accepts_nested_attributes_for :addresses, allow_destroy: true, reject_if: :all_blank
  end

end
