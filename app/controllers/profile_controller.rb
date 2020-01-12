class ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :prepare_data, only: [:index]

  def index
  end

  protected

    def prepare_data
      @my_reservations = Reservation.outgoing_reservation_for(current_user)
      @incoming_reservations = Reservation.incoming_reservation_for(current_user)
      @favorite_posts = FavoritePost.by_user(current_user)
      @my_posts = Post.by_user(current_user).paginate(page: params[:page], per_page: 4)
    end
end
