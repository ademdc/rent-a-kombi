class HomeController < ApplicationController
  def home
    @posts = Post.new
  end
end
