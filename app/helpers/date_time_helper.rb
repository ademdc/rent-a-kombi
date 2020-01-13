module DateTimeHelper

  def message_datetime(created_at)
    days_ago = get_day_ago(created_at)

    hours_format = created_at.strftime("at %H:%M")
    date_format = created_at.strftime("at %l:%D %M")

    if days_ago > 1
      if (1..15).to_a.include?(days_ago)
        return "#{days_ago} days ago, #{hours_format}"
      end
      return date_format
    end

    hours_format
  end

  def get_day_ago(created_at)
    (Time.current.to_date - created_at.to_date).to_i
  end

  def formated_date(date)
    date.strftime('%d/%m/%Y')
  end

end