class UserMailer < ApplicationMailer
  def reservation_confirmation
    @reservation = params[:reservation]
    mail(:to => @reservation.post.user.email, :subject => "Upcoming Reservation for #{@reservation.post.title}")
  end
end
