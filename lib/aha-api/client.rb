require 'aha-api/version'

require 'aha-api/configuration'
require 'aha-api/connection'
require 'aha-api/request'

require 'aha-api/resources/features'
require 'aha-api/resources/ideas'
require 'aha-api/resources/comments'
require 'aha-api/resources/integration_fields'
require 'aha-api/resources/integration_candidates'

module AhaApi
  class Client
    include AhaApi::Connection
    include AhaApi::Request
    include AhaApi::Resource::Features
    include AhaApi::Resource::Ideas
    include AhaApi::Resource::Comments
    include AhaApi::Resource::IntegrationFields
    include AhaApi::Resource::IntegrationCandidates

    # api_endpoint has its own reader below, which falls back to this client's domain and URL base
    OPTION_KEYS = (Configuration::VALID_OPTIONS_KEYS - [:api_endpoint]).freeze

    attr_accessor(*OPTION_KEYS)
    attr_writer :api_endpoint

    # Each option comes from the given options, falling back to the global configuration (AhaApi.configure). The
    # global configuration is only read. Writing a client's options into it let clients created at the same time on
    # other threads take that client's domain, token and logger, and left them as the defaults for later clients.
    def initialize(options={})
      OPTION_KEYS.each do |key|
        send("#{key}=", options[key] || AhaApi.send(key))
      end

      self.api_endpoint = options[:api_endpoint]
    end

    def api_endpoint
      # Use the given endpoint or fallback to one built from this client's own domain and URL base
      @api_endpoint || Configuration.api_endpoint_for(domain, url_base)
    end
  end
end
