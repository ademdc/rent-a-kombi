module Utils
  module HashUtils
    def keys_to_snake_case(hash)
      transformed = {}

      hash.each do |k, v|
        key = k.to_s.underscore
        value = v.is_a?(Hash) ? camelize_keys(v) : v
        transformed[key] = value
      end

      transformed
    end

    def convert_keys_to_camel_case(value)
      case value
      when Array
        value.map { |v| convert_keys_to_camel_case(v) }
      when Hash
        Hash[value.map { |k, v| [k.to_s.camelize(:lower), convert_keys_to_camel_case(v)] }]
      else
        value
      end
    end

    extend self
  end
end

