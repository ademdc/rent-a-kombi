class PostsController < ApplicationController
  include PostsHelper

  before_action :set_post, only: [:show, :edit, :update, :destroy, :available]
  before_action :authenticate_user!, except: [:show, :search]
  before_action :get_image, only: [:remove_attachment]

  def index
    @posts = Post.by_user(current_user).paginate(page: params[:page])
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.images.attach(params[:post][:images]) if params[:post][:images]
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        @post.images.attach(params[:post][:images]) if params[:post][:images]

        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    cookies[:availability_from]  = params[:search][:availability_from]
    cookies[:availability_to]  = params[:search][:availability_to]
    @posts = Post.filter(search_post_params).paginate(page: params[:page])
  end

  def available
    byebug
    status = @post.available?(params[:available_from], params[:available_to])

    respond_to do |format|
      format.json { render json: status, status: :ok }
    end
  end

  def remove_attachment
    @image.purge
    redirect_back(fallback_location: request.referer)
  end

  def set_favorite_post
    FavoritePost.create!(user_id: params[:user_id], post_id: params[:post_id])
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def get_image
      @image = ActiveStorage::Attachment.find(params[:id])
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
        :availability_to
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
        :kw)
    end
end
