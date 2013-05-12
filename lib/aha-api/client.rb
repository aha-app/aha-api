require 'aha-api/version'

require 'aha-api/configuration'
require 'aha-api/connection'
require 'aha-api/request'

require 'aha-api/resources/features'
require 'aha-api/resources/meta'

module AhaApi
  class Client
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    def initialize(options={})
      options = AhaApi.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    include AhaApi::Connection
    include AhaApi::Request

    include AhaApi::Resource::Features
    include AhaApi::Resource::Meta
  end
end
