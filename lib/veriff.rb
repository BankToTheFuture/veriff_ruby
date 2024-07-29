# frozen_string_literal: true

require 'httparty'
require 'veriff/parser'

require 'veriff/version'

require 'veriff/configuration'
require 'veriff/security'

require 'veriff/model'
require 'veriff/media_holder'
require 'veriff/attempt'
require 'veriff/media'
require 'veriff/person'
require 'veriff/session'
require 'veriff/timestamp'
require 'veriff/decision'
require 'veriff/watchlist_screening'

require 'veriff/webhook'
require 'veriff/webhooks/invalid_signature_error'
require 'veriff/webhooks/event'
require 'veriff/webhooks/decision'
require 'veriff/webhooks/fullauto'
require 'veriff/webhooks/watchlist_screening'

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
    'X-HMAC-SIGNATURE' => ->(options) { generate_signature(options) }
  )
end
