module DatatableDSL
  module Decorator
    def decorated(records, view_context)
      records.map { |record| @decorator_method.call(record, view_context) }
    end

    def decorate(&block)
      @decorator_method = block
    end
  end
end
