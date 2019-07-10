# frozen_string_literal: true

module Veriff
  module Security
    def generate_signature(options)
      Digest::SHA256.hexdigest(
        "#{options[:signature] || options[:body]}#{configuration.api_secret}"
      )
    end
  end
end
