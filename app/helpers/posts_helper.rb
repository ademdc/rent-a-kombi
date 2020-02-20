module PostsHelper

  IGNORE_PARAMS=[:latitude, :longitude]

  def get_filtered_posts(params)
    @from, @to = params[:availability].split('to').map(&:to_datetime)
    range = @from.beginning_of_day..@to.end_of_day

    reserved_post_ids = Reservation.where(start: range).or(Reservation.where(end: range)).pluck(:post_id)
    @posts = Post.all_except(reserved_post_ids)
  end

  def filter_availability
  end

  def capitalized_models
    Vehicles::Models::MODELS.map { |model|  t("search.models.#{model}") }
  end

  def capitalized_fuels
    Posts::Filters::FUEL.map { |fuel|  t("search.fuels.#{fuel}") }
  end

  def capitalized_transmissions
    Posts::Filters::TRANSMISSION.map { |transmission|  t("search.transmissions.#{transmission}") }
  end

  def currencies_collection
    Currency.all.map { |currency| [currency.code, currency.id] }
  end

  def sanitized_search_param(params, param)
    params[:search][param]
  end

  def post_search_tags(params)
    html = ''
    params[:search].each do |key, value|
      next if IGNORE_PARAMS.include?(key.to_sym)
      if value.present?
        html += (content_tag :div, '', class: 'info-tag mb-2' do
          concat content_tag :span, key, class: 'left'
          concat content_tag :span, sanitize(value), class: 'right'
        end)
      end
    end

    html.html_safe
  end

  def send_message_icon(current_user)
    url = new_user_session_path
    data_target = ''
    data_toggle = ''

    if current_user.present?
      url = '#'
      data_target = '#modalContactForm'
      data_toggle = 'modal'
    end

    content_tag :span, '' do
      link_to message_icon, url, class: 'btn btn-sm btn-success btn-rounded btn-app mr-2 btn-send-msg', data: { target: data_target, toggle: data_toggle }
    end
  end

  def favorite_post_icon(current_user)
    return unless current_user.present?

    is_favorite_post = current_user.present? && current_user.is_favorite_post?(@post) ? 'btn-red' : ''

    content_tag :span, '' do
      link_to heart_icon, '#', class: "btn btn-sm btn-success btn-rounded btn-app js-add-favorite-post #{is_favorite_post}", data: { url: set_favorite_post_post_path(@post), post_id: @post.id, user_id: current_user.id }
    end
  end

  def posts_with_reservations_in_range_for?(reservation)
    Post.where(id: reservation.post.id).with_reservations_in_range(reservation.start..reservation.end)
  end

  def main_information(value, klass, title)
    content_tag :p, '' do
      concat content_tag :i, '', class: "fa fa-#{klass}", "data-toggle": "tooltip", 'title':title
      concat value
    end
  end

  def availability_cookies?
    cookies[:availability_from].present? && cookies[:availability_to].present?
  end

  def currency_for_locale(locale)
    case locale
    when 'bs'
      'KM'
    when 'en'
      '€'
    else
      'KM'
    end
  end
end
