module DatatableDSL
  def self.included(base)
    base.send :include, DatatableDSL::Query
    base.extend DatatableDSL::Decorator
    base.extend DatatableDSL::Configurator
    base.extend DatatableDSL::Columns
  end

  def initialize(view_context = nil)
    @view_context = view_context
  end

  def h
    @view_context
  end

  def server_side_processing?
    self.class.instance_variable_get(:@configuration).get[:server_side]
  end

  def records_page
    records.all
  end

  def all_records
    Utils::HashUtils.convert_keys_to_camel_case(
      records_total: records.count,
      records_filtered: records.count
    ).merge(data: self.class.decorated(records, h))
  end

  def as_json(options = {})
    return all_records unless server_side_processing?

    if options[:ids]
      { data: self.class.decorated(records.where(id: options[:ids]), h) }
    else
      Utils::HashUtils.convert_keys_to_camel_case(
        records_total: records.count,
      ).merge(data: self.class.decorated(records_page, h))
    end
  end
end
