module ReservationHelper
  def upocoming_reservation(user, post)
    return unless user.present?
    reservations = user.reservations_for(post).last

    return unless reservations.present?

    reservation_confirmed = reservations.confirmed ? t('post.confirmed').downcase : t('post.pending').downcase

    content_tag :div do
      concat warning_icon('mr-2')
      concat content_tag :span, t('post.have_reservation', reservation_confirmed: reservation_confirmed)
      concat link_to t('post.see_reservations'), profile_index_path, class: 'd-block mb-2'
    end
  end
end
