# frozen_string_literal: true

module Veriff
  class Timestamp < Model
    def algorithm
      data_hash[:algorithm]
    end

    def value
      data_hash[:value]
    end
  end
end
