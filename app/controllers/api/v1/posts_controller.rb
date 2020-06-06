class Api::V1::PostsController < Api::V1::ApplicationController
  respond_to :json
  skip_before_action :require_login, only: [:search, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :available, :check_address]

  def index
    respond_with Post.by_user(@current_user)
  end

  def create
    @post = Post.new(post_params)
    attach_images(@post)
    @post.save!

    respond_with @post
  end

  def search
    current_user = User.find(params[:user_id])
    @posts = Post.filter(search_post_params).not_from_user(current_user).order('created_at desc')

    respond_with @posts
  end

  def show
    respond_with @post
  end


  private

  def set_post
    @post = Post.find(params[:id])
  end

  def attach_images(post)
      post.images.attach(params[:post][:images]) if params[:post][:images]
    end

  def search_post_params
      params.require(:search).permit(
        :category,
        :model,
        :price_from,
        :price_to,
        :fuel,
        :transmission,
        :year_from,
        :year_to,
        :availability,
        :availability_from,
        :availability_to,
        :city
        )
    end

  def post_params
    params.require(:post).permit(
      :title,
      :user_id,
      :category_id,
      :images,
      :description,
      :contact,
      :model,
      :production_year,
      :fuel,
      :milage,
      :transmission,
      :price,
      :number_of_seats,
      :hp,
      :kw,
      :currency_id,
      address_attributes: addresses_attributes)
    end


    def respond_with(resource, _opts = {})
      render json: resource
    end

    def respond_to_on_destroy
      head :ok
    end
end
