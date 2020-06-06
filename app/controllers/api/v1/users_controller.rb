class Api::V1::UsersController  < Api::V1::ApplicationController
  respond_to :json

  def index
    render json: User.all
  end

  def set_push_token
    @current_user.set_push_token(params[:push_token])
    if @current_user.save
      render json: { user: @current_user, userId: @current_user.id, push_token: @current_user.push_token }
    else
      render json: { errors: @current_user.errors.full_messages }, status: :not_acceptable
    end
  end
end
