module AddressHelper
  BIH = 'Bosnia and Herzegovina'

  def all_countries
    ISO3166::Country.all.map(&:name).sort
  end

  def get_country_code(country)
    ISO3166::Country.find_country_by_name(country).un_locode
  end

  def address_exist_for?(post)
    @post.address&.persisted? || @post.user&.address&.present?
  end

  def address_autocomplete_input
    content_tag :div, class: 'form-group' do
      concat text_field_tag :'address-autocomplete', '', class: 'form-control string', placeholder: 'Enter address'
    end
  end

end
