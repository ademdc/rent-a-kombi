module DatatableDSL
  module Configurator
    def configuration
      Utils::HashUtils.convert_keys_to_camel_case(@configuration.get)
    end

    def configure(&block)
      @configuration = DatatableDSL::Configuration.new(columns)
      @configuration.instance_eval(&block)
    end

    def override_configuration(&block)
      @configuration.instance_eval(&block)
      self
    end
  end
end
