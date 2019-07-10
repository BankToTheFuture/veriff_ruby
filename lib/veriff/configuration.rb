# frozen_string_literal: true

module Veriff
  module Configuration
    DEFAULT_CONFIG = {
      base_uri: 'https://api.veriff.me/v1'
    }.freeze

    def configuration
      @configuration ||= OpenStruct.new(DEFAULT_CONFIG)
    end

    def configure
      yield(configuration)
      reload_config
    end

    def reload_config
      base_uri configuration.base_uri
      true
    end
  end
end
