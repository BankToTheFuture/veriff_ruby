# frozen_string_literal: true

module Veriff
  module Webhook
    def parse(body, signature)
      return new(body) if Veriff.validate_signature(body, signature)

      raise Webhooks::InvalidSignatureError, "Given signature #{signature} does not match body and API Secret"
    end
  end
end
