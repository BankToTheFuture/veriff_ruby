# frozen_string_literal: true

module Veriff
  class Media < Model
    def file
      @file ||= Tempfile.open(@data_hash[:name] || 'unknown') do |f|
        f.write Veriff.get("/media/#{id}", signature: id).body
        f
      end
    end

    def timestamp
      @timestamp ||= Timestamp.new(@data_hash[:timestamp])
    end
  end
end
