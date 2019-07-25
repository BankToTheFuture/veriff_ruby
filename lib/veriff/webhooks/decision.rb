# frozen_string_literal: true

module Veriff
  module Webhooks
    class Decision < Model
      extend Webhook

      def initialize(body)
        super(Parser.call(body, :json)[:verification])
      end

      def person
        @person ||= OpenStruct.new(@data_hash[:person])
      end

      def document
        @document ||= OpenStruct.new(@data_hash[:document])
      end
    end
  end
end
