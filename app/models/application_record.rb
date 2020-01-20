class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  DATE_FORMAT = '%d/%m/%Y'

  def pp_join(array, delimiter = ', ')
    array.compact.reject(&:empty?).join(delimiter)
  end

  def formatted_date(field)
    send(field)&.strftime(DATE_FORMAT) rescue nil
  end
end
