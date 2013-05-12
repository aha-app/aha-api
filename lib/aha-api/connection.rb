require 'faraday_middleware'
require 'faraday/response/raise_aha_error'

module AhaApi
  # @private
  module Connection
    private

    def connection(options={})
      options = {
        :authenticate     => true,
        :force_urlencoded => false,
        :raw              => false
      }.merge(options)

      if domain.nil? || domain.empty?
        raise ConfigurationError, "domain must be specified"
      end
      
      if !proxy.nil?
        options.merge!(:proxy => proxy)
      end

      # TODO: Don't build on every request
      connection = Faraday.new(options) do |builder|

        if options[:force_urlencoded]
          builder.request :url_encoded
        else
          builder.request :json
        end

        builder.use Faraday::Response::RaiseAhaError
        builder.use FaradayMiddleware::FollowRedirects
        builder.use FaradayMiddleware::Mashify

        builder.use FaradayMiddleware::ParseJson, :content_type => /\bjson$/

        faraday_config_block.call(builder) if faraday_config_block

        builder.adapter *adapter
      end

      connection.basic_auth login, password

      connection.headers[:user_agent] = user_agent

      connection
    end
  end
end
