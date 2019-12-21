module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    include ApplicationHelper

    def filter(filtering_params)
      results = self.where(nil)
      filtering_params.each do |key, value|
        results = results.public_send("by_#{key}", sanitize(value)) if value.present?
      end
      results
    end

  end
end
