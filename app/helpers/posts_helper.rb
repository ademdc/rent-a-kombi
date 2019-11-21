module PostsHelper
  def get_reserved_posts(range)
    @from, @to = range.split('to').map(&:to_datetime)
    range = @from.beginning_of_day..@to.end_of_day

    reserved_post_ids = Slot.where(start: range).or(Slot.where(end: range)).pluck(:post_id)
    @posts = Post.all_except(reserved_post_ids)
  end
end
