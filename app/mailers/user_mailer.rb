class UserMailer < ApplicationMailer
  def reservation_confirmation
    @reservation = params[:reservation]
    mail(:to => @reservation.post.user.email, :subject => I18n.t('mailer.reservation.upcoming_reservation', title: @reservation.post.title))
  end
end
