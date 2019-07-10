# frozen_string_literal: true

module Veriff
  class Model
    def initialize(data_hash)
      data_hash.fetch(:id)
      @data_hash = data_hash
    end

    def respond_to_missing?(method_name, include_private = false)
      @data_hash.key?(method_name) || super
    end

    def method_missing(method_name, *_args)
      @data_hash.key?(method_name) ? @data_hash[method_name] : super
    end

    def self.api_collection_name
      "#{name.gsub('Veriff::', '').downcase}s"
    end
  end
end
