class DucatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @ducat_count = current_user.ducats
  end
end