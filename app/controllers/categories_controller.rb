class CategoriesController < ActionController::Base
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def show
  end

  def edit
  end

  def new
    @post = Post.new
  end

  def create
  end

  def destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:post).permit(:name)
  end


end
