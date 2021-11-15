# frozen_string_literal: true

module Veriff
  module Webhooks
    class WatchlistScreening < Model
      extend Webhook

      def initialize(body)
        super(Parser.call(body, :json))
      end
    end
  end
end
