# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def reservation_confirmation
    @reservation = Reservation.last

    UserMailer.with(reservation: @reservation).reservation_confirmation
  end
end
