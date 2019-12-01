class HomeController < ApplicationController
  layout 'home'

  def home
    @posts = Post.new
  end

  def locale
  end

end
