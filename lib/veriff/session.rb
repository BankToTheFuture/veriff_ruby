# frozen_string_literal: true

module Veriff
  class Session < Model
    class << self
      def create(params = {})
        params[:features]  ||= [:selfid]
        params[:timestamp] ||= Time.now.utc.iso8601(3)

        verification = Veriff.post(
          '/sessions', body: { verification: params }.to_json
        ).parsed_response[:verification]

        new(verification)
      end
    end

    include MediaHolder

    def person
      @person ||= Person.new(Veriff.get("/sessions/#{id}/person", signature: id)
                               .parsed_response[:person])
    end

    def timestamps
      @timestamps ||= Veriff.get("/sessions/#{id}/timestamps", signature: id)
                            .parsed_response[:timestamps].map do |timestamp|
        Timestamp.new(timestamp)
      end
    end

    def attempts
      @attempts ||= Veriff.get("/sessions/#{id}/attempts", signature: id)
                          .parsed_response[:verifications].map do |attempt|
        Attempt.new(attempt)
      end
    end

    def decision
      @decision ||= Decision.new(
        Veriff.get("/sessions/#{id}/decision", signature: id)
                                   .parsed_response[:verification]
      )
    end

    def watchlist_screening
      @watchlist_screening ||= WatchlistScreening.new(
        Veriff.get("/sessions/#{id}/watchlist-screening", signature: id).parsed_response[:data]
      )
    end
  end
end
