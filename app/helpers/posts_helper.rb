module PostsHelper

  IGNORE_PARAMS=[:latitude, :longitude]

  def get_filtered_posts(params)
    @from, @to = params[:availability].split('to').map(&:to_datetime)
    range = @from.beginning_of_day..@to.end_of_day

    reserved_post_ids = Slot.where(start: range).or(Slot.where(end: range)).pluck(:post_id)
    @posts = Post.all_except(reserved_post_ids)
  end

  def filter_availability
  end

  def capitalized_models
    Vehicles::Models::MODELS.map(&:to_s)
  end

  def capitalized_fuels
    Posts::Filters::FUEL.map(&:to_s)
  end

  def capitalized_transmissions
    Posts::Filters::TRANSMISSION.map(&:to_s)
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

    if current_user.present? && !current_user.my_post?(@post)
      url = '#'
      data_target = '#modalContactForm'
      data_toggle = 'modal'
    end

    content_tag :span, '' do
      link_to message_icon, url, class: 'btn btn-sm btn-success btn-rounded btn-app mr-2', data: { target: data_target, toggle: data_toggle }
    end
  end

  def favorite_post_icon(current_user)
    return unless current_user.present?

    is_favorite_post = current_user.present? && current_user.is_favorite_post?(@post) ? 'btn-red' : ''

    content_tag :span, '' do
      link_to heart_icon, '#', class: "btn btn-sm btn-success btn-rounded btn-app js-add-favorite-post #{is_favorite_post}", data: { url: set_favorite_post_post_path(@post), post_id: @post.id, user_id: current_user.id }
    end
  end

  def posts_with_slots_in_range_for?(slot)
    Post.where(id: slot.post.id).with_slots_in_range(slot.start..slot.end)
  end


end
