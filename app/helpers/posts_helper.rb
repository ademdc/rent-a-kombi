module PostsHelper
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
end
