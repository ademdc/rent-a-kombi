class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]

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
    date = params[:post][:title]
    @from, @to = date.split('-').map(&:to_datetime)
    @posts = Post.joins(:slots).where('slots.start > ? OR slots.end < ?', @from, @to).uniq
  end

  def remove_attachment
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge
    redirect_back(fallback_location: request.referer)
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(
        :title,
        :category_id,
        :images,
        :description,
        :contact,
        vehicle_attributes: [:model, :production_year, :gas_type, :milage])
    end
end
