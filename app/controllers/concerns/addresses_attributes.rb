module AddressesAttributes
  def addresses_attributes
    [:id, :address, :street_number, :city, :zip, :country, :latitude, :longitude, :reference_id, :reference_type, :_destroy]
  end
end
