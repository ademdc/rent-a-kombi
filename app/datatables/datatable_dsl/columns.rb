module DatatableDSL
  module Columns
    def columns
      @columns ||= []
    end

    def register_column(column_name, options = {})
      columns << options.tap do |new_column|
        new_column[:data] = column_name
        new_column[:title] = I18n.t("columns.#{column_name}", scope: @locale_scope)
        new_column[:label] = new_column[:title]
        new_column[:name] = column_name

        new_column[:class_name] = column_name.to_s
        new_column[:class_name] += ' editable' if options[:editable]
        new_column[:class_name] += " #{options[:additional_classes]}" if options[:additional_classes]

        new_column[:searchable] = options[:searchable] || false
        new_column[:orderable] = options[:orderable] || false
        new_column[:visible] = options[:visible].nil? ? true : options[:visible]
      end
    end

    def set_locale_scope(scope)
      @locale_scope = scope
    end
  end
end
