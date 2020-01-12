class UserMailer < ApplicationMailer
  def reservation_confirmation
    @reservation = params[:reservation]
    @receiver = @reservation.post.user
    @localized_subject = I18n.with_locale(@receiver.locale.to_sym) { I18n.t('mailer.reservation.upcoming_reservation', title: @reservation.post.title) }

    mail(
      :to => @receiver.email,
      :subject => @localized_subject
    )
  end
end
