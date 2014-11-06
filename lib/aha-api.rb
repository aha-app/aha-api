require 'faraday'
require 'faraday_middleware'

require 'aha-api/configuration'
require 'aha-api/error'
require 'aha-api/client'

module AhaApi
  extend Configuration
  class << self
    # Alias for AhaApi::Client.new
    #
    # @return [AhaApi::Client]
    def new(options={})
      AhaApi::Client.new(options)
    end

    # Delegate to AhaApi::Client.new
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private=false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end
