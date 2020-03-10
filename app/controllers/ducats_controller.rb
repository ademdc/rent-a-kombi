class DucatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @ducat_count = current_user.ducats
    @purchase = Purchase.new
  end
end