module DateTimeHelper

  def message_datetime(created_at)
    days_ago = get_day_ago(created_at)

    hours_format = created_at.strftime("#{I18n.t('at')} %H:%M")
    date_format = created_at.strftime("%d/%m/%Y #{I18n.t('at')} %H:%M")

    if days_ago > 1
      if (1..7).to_a.include?(days_ago)
        return "#{I18n.t('days_ago', number: days_ago)}, #{hours_format}"
      end
      return date_format
    end

    hours_format
  end

  def get_day_ago(created_at)
    (Time.current.to_date - created_at.to_date).to_i
  end

  def formated_date(date, with_time=false)
    return date.strftime(ApplicationRecord::DATE_TIME_FORMAT) if with_time
    date.strftime(ApplicationRecord::DATE_FORMAT)
  end

end