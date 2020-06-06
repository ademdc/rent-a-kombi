class RegistrationsController < Api::V1::ApplicationController
  respond_to :json

  skip_before_action :require_login, only: [:create]

  def create
    user = User.create(email: params[:users][:email], password: params[:users][:password])

    if user.valid?
        payload = { user_id: user.id }
        token = encode_token(payload)
        puts token
        render json: { user: user, userId: user.id, jwt: token }
    else
        render json: { errors: user.errors.full_messages }, status: :not_acceptable
    end
  end

  protected

  def user_params
    params.permit(:email, :password)
  end
end
