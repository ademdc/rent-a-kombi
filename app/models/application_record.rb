class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  DATE_FORMAT = '%d/%m/%Y'
  DATE_TIME_FORMAT = '%d/%m/%Y %H:%M'
  WEEK_DAY_FORMAT = '%A'

  def pp_join(array, delimiter = ', ')
    array.compact.reject(&:empty?).join(delimiter)
  end

  def formatted_date(field, with_date_time = false)
    return send(field)&.strftime(DATE_TIME_FORMAT) rescue nil if with_date_time
    send(field)&.strftime(DATE_FORMAT) rescue nil
  end

  def formatted_date_time_w_week_day(field)
    ("#{send(field)&.strftime(DATE_TIME_FORMAT)} - <i>#{formatted_week_day(field)}</i>").html_safe rescue nil
  end

  def formatted_week_day(field)
    I18n.t("days.#{send(field)&.strftime(WEEK_DAY_FORMAT).underscore}") rescue nil
  end
end
