# frozen_string_literal: true

module Veriff
  class WatchlistScreening < Model
    def initialize(data_hash)
      data_hash.fetch(:attempt_id)
      @data_hash = data_hash
    end
  end
end
