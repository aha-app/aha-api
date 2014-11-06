require 'aha-api/version'

require 'aha-api/configuration'
require 'aha-api/connection'
require 'aha-api/request'

require 'aha-api/resources/features'
require 'aha-api/resources/ideas'
require 'aha-api/resources/comments'
require 'aha-api/resources/integration_fields'
require 'aha-api/resources/meta'

module AhaApi
  class Client
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    def initialize(options={})
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        AhaApi.send("#{key}=", options[key]) if options[key]
        send("#{key}=", AhaApi.send(key))
      end
    end

    include AhaApi::Connection
    include AhaApi::Request

    include AhaApi::Resource::Features
    include AhaApi::Resource::Ideas
    include AhaApi::Resource::Comments
    include AhaApi::Resource::IntegrationFields
    include AhaApi::Resource::Meta
  end
end
