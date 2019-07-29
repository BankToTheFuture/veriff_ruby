# frozen_string_literal: true
require 'stringio'

module Veriff
  class Media < Model
    def file
      StringIO.new(Veriff.get("/media/#{id}", signature: id).body)
    end

    def timestamp
      @timestamp ||= Timestamp.new(@data_hash[:timestamp])
    end
  end
end
