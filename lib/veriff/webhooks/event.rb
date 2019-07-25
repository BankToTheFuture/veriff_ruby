module Veriff
  module Webhooks
    class Event < Model
      extend Webhook

      def initialize(body)
        super(Parser.call(body, :json))
      end
    end
  end
end
