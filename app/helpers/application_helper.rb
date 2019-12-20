module ApplicationHelper
  def google_map_url
    raise 'Environment variable not set for google maps' unless ENV['GMAP_API_KEY']

    "https://maps.googleapis.com/maps/api/js?key=#{ENV['GMAP_API_KEY']}&libraries=places&language=en"
  end

  def google_map_clusters
    'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js'
  end

  def font_awesome_url
    'https://kit.fontawesome.com/f1327831ac.js'
  end

  def logged_in?
    current_user.present?
  end
end
