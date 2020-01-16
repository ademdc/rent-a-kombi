class UsersController < ApplicationController
  before_action :set_data, only: [:show]

  def show
  end

  private
    def set_data
      @user   = User.find(params[:id])
      @posts  = Post.where(user_id: params[:id]).paginate(page: params[:page], per_page: 10)
    end
end
