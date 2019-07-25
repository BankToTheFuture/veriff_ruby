# frozen_string_literal: true

module Veriff
  module Security
    def generate_signature(options)
      Digest::SHA256.hexdigest(
        "#{options[:signature] || options[:body]}#{configuration.api_secret}"
      )
    end

    def validate_signature(body, signature)
      generate_signature(body: body) == signature
    end
  end
end
