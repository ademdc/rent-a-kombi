module ApplicationHelper
  def google_map_url
    raise 'Environment variable not set for google maps' unless ENV['GMAP_API_KEY']

    "https://maps.googleapis.com/maps/api/js?key=#{ENV['GMAP_API_KEY']}&libraries=places&language=en"
  end
end
