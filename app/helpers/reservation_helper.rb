module ReservationHelper
  def upocoming_reservation(user, post)
    return unless user.present?
    reservations = user.reservations_for(post).last

    return unless reservations.present?

    reservation_confirmed = reservations.confirmed ? 'confirmed' : 'pending'

    content_tag :div do
      concat warning_icon('mr-2')
      concat content_tag :span, "You have a #{reservation_confirmed} reservation for this post"
      concat link_to 'See reservations', profile_index_path, class: 'd-block mb-2'
    end
  end
end
