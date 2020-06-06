class Api::V1::PostsController < Api::V1::ApplicationController
  respond_to :json
  #skip_before_action :require_login, only: [:create]

  def index
    respond_with Post.all
  end

  def search
  end

  private

    def respond_with(resource, _opts = {})
      render json: resource
    end
    def respond_to_on_destroy
      head :ok
    end
end
