class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def pp_join(array, delimiter = ', ')
    array.compact.reject(&:empty?).join(delimiter)
  end
end
