module UserHelper
  def user_posts_count(count)
    content_tag :div do
      concat content_tag :p, t('user.total_uploaded')
      concat content_tag :span, count, class: 'count'
    end
  end

  def user_phone_number(number)
    content_tag :div do
      concat content_tag :p, t('user.phone_number')
      if number.present?
        concat content_tag :span, number, class: 'count'
      else
        concat content_tag :span, t('na'), class: 'count'
      end
    end
  end

  def user_address(address)
    content_tag :div do
      concat content_tag :p, t('user.address')
      if address.present?
        concat content_tag :span, address.short_address, class: 'count'
      else
        concat content_tag :span, t('na'), class: 'count'
      end
    end
  end

  def locale_collection
    Users::Locales::ALL.map { |lang| [I18n.t("languages.#{lang}"), lang] }
  end

end
