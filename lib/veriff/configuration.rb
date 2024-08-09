# frozen_string_literal: true

module Veriff
  module Configuration
    DEFAULT_CONFIG = {
      base_uri: 'https://api.veriff.me/v1'
    }.freeze

    Config = Struct.new(:api_key, :api_secret, :base_uri, keyword_init: true)

    def configuration
      @configuration ||= Config.new(**DEFAULT_CONFIG)
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
