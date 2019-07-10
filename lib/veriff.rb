# frozen_string_literal: true

require 'httparty'
require 'veriff/parser'

require 'veriff/version'

require 'veriff/configuration'
require 'veriff/security'

require 'veriff/model'
require 'veriff/media_holder'
require 'veriff/attempt'
require 'veriff/decision'
require 'veriff/media'
require 'veriff/person'
require 'veriff/session'
require 'veriff/timestamp'

module Veriff
  include HTTParty
  extend Configuration
  extend Security

  base_uri configuration.base_uri
  parser(Veriff::Parser)
  raise_on(400...600)

  headers(
    'CONTENT-TYPE' => 'application/json',
    'X-AUTH-CLIENT' => -> { configuration.api_key },
    'X-SIGNATURE' => ->(options) { generate_signature(options) }
  )
end
