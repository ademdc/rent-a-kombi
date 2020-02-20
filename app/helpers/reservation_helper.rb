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

  def post_not_available_container(available)
    is_hidden = available ? 'hidden' : ''
    is_hidden += availability_cookies? ? '' : 'hidden'

    content_tag :div, '', class: "js-not-available not-available #{is_hidden}" do
      concat inline_svg 'letter-x.svg', style: 'height: 30px; display: inline;'
      concat content_tag :span, t('post.car_unavailable')
    end
  end

  def post_available_container(available)
    is_hidden = available ? '' : 'hidden'

    content_tag :div, '', class: "js-available available #{is_hidden}" do
      concat inline_svg 'check.svg', style: 'height: 40px; display: inline;'
      concat content_tag :span, t('post.car_available')
      concat (content_tag :span, '' do
        button_tag car_icon(t('post.reserve').upcase), class: 'btn js-rent btn-success btn btn-reserve', style: 'width: 100%'
      end)
    end
  end


end
