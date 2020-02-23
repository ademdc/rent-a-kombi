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

  def sanitize(string)
    string.split(',').first
  end

  def direct_upload_url
    '/rails/active_storage/direct_uploads'
  end

  def link_to_add_fields(name = nil, f = nil, association = nil, options = nil, html_options = nil, &block)
    # If a block is provided there is no name attribute and the arguments are
    # shifted with one position to the left. This re-assigns those values.
    f, association, options, html_options = name, f, association, options if block_given?

    options = {} if options.nil?
    html_options = {} if html_options.nil?

    if options.include? :locals
      locals = options[:locals]
    else
      locals = { }
    end

    if options.include? :partial
      partial = options[:partial]
    else
      partial = association.to_s.singularize + '_fields'
    end

    # Render the form fields from a file with the association name provided
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, child_index: 'new_record') do |builder|
      render(partial, locals.merge!( f: builder))
    end

    # The rendered fields are sent with the link within the data-form-prepend attr
    html_options['data-form-append'] = raw CGI::escapeHTML( fields )
    html_options['href'] = '#'

    content_tag(:a, name, html_options, &block)
  end
end
