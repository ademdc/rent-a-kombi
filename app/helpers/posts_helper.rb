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
end
