class Api::V1::SessionsController < Devise::SessionsController
  # respond_to :json
  # skip_before_action :require_login, only: [:create]

  # def create
  #   user = User.find_by(email: params[:users][:email])

  #   if user && user.valid_password?(params[:users][:password])
  #       payload = { user_id: user.id }
  #       token = encode_token(payload)
  #       puts "-----> Token: #{token} <------"

  #       render json: {user: user, userId: user.id, jwt: token, success: "Welcome back, #{user.email}"}
  #   else
  #       render :status => 400
  #   end
  # end

  # private

  #   def respond_with(resource, _opts = {})
  #     render json: resource
  #   end
  #   def respond_to_on_destroy
  #     head :ok
  #   end
end
