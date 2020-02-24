class UsersController < ApplicationController
  before_action :set_data, only: [:show]

  def show
  end

  def add_ducats
    current_user.add_ducats(params[:ducat_number])
  end

  private
    def set_data
      @user   = User.find_by_slug(params[:slug])
      @posts  = Post.where(user_id: @user.id).paginate(page: params[:page], per_page: 10)

      redirect_to root_path unless @user
    end
end
