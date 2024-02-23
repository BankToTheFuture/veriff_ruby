# frozen_string_literal: true

module Veriff
  module Security
    def generate_signature(options)
      digest = OpenSSL::Digest.new('sha256')
      OpenSSL::HMAC.hexdigest(digest, configuration.api_secret, options[:body])
    end

    def validate_signature(body, signature)
      generate_signature(body: body) == signature
    end
  end
end
