module DatatableDSL
  module Query
    def self.included(base)
      base.extend ClassMethods
    end

    def records
      col = self.class.records
      if col.respond_to?(:call)
        col.call(@view_context)
      else
        col
      end
    end

    module ClassMethods
      def collection(query)
        @records = query
      end

      def collection_with_view(&block)
        @records = block
      end

      def records
        @records
      end
    end
  end
end
