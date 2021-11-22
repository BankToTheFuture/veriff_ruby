# frozen_string_literal: true

module Veriff
  module Webhooks
    class WatchlistScreening < Model
      extend Webhook

      def initialize(body)
        data_hash = Parser.call(body, :json)
        data_hash.fetch(:attempt_id)
        @data_hash = data_hash
      end
    end
  end
end
