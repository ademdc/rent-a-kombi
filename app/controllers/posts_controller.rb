class PostsController < ApplicationController
  include PostsHelper
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :search]
  before_action :get_image!, only: [:remove_attachment]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
    @post.build_vehicle
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
    @posts = get_reserved_posts(params[:search][:daterange])
  end

  def remove_attachment
    @image.purge
    redirect_back(fallback_location: request.referer)
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def get_image
      @image = ActiveStorage::Attachment.find(params[:id])
    end

    def post_params
      params.require(:post).permit(
        :title,
        :user_id,
        :category_id,
        :images,
        :description,
        :contact,
        vehicle_attributes: [:model, :production_year, :gas_type, :milage])
    end
end
