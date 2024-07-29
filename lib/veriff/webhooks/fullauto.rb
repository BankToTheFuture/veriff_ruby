# frozen_string_literal: true

module Veriff
  module Webhooks
    class Fullauto < Model
      extend Webhook

      def initialize(body)
        super(Parser.call(body, :json))
      end

      def data
        @data ||= OpenStruct.new(@data_hash[:data])
      end

      def id
        session_id
      end

      def verification
        @verification ||= OpenStruct.new(data.verification)
      end

      def person
        @person ||= OpenStruct.new(verification.person)
      end

      def document
        @document ||= OpenStruct.new(verification.document)
      end
    end
  end
end
