# frozen_string_literal: true

module Veriff
  class Decision < Model
    def person
      @person ||= OpenStruct.new(@data_hash[:person])
    end

    def document
      @document ||= OpenStruct.new(@data_hash[:document])
    end
  end
end
