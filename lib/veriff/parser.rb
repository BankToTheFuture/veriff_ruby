# frozen_string_literal: true

module Veriff
  class Parser < HTTParty::Parser
    SUPPORTED_FORMATS = { 'application/json' => :json }.freeze

    def self.formats
      SUPPORTED_FORMATS
    end

    protected

    def json
      deep_transform_keys(JSON.parse(body)) do |key|
        underscore(key).to_sym
      end
    end

    private

    # source: https://apidock.com/rails/v5.2.3/Hash/_deep_transform_keys_in_object
    def deep_transform_keys(object, &block)
      case object
      when Hash
        object.each_with_object({}) do |(key, value), result|
          result[yield(key)] = deep_transform_keys(value, &block)
        end
      when Array
        object.map { |e| deep_transform_keys(e, &block) }
      else
        object
      end
    end

    # source:  https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb#L91
    def underscore(camel_cased_word)
      return camel_cased_word unless /[A-Z-]|::/.match?(camel_cased_word)

      word = camel_cased_word.to_s.gsub(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
      word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
      word.tr!('-', '_')
      word.downcase!
      word
    end
  end
end
