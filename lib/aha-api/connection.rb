require 'faraday_middleware'
require 'faraday/response/raise_aha_error'

module AhaApi
  # @private
  module Connection
    private

    def connection(options={})
      if domain.nil? || domain.empty?
        raise ConfigurationError, "domain must be specified"
      end

      if !proxy.nil?
        options.merge!(:proxy => proxy)
      end

      # TODO: Don't build on every request
      Faraday.new(options) do |builder|
        builder.request :json
        builder.request(:basic_auth, login, password)

        builder.use Faraday::Response::RaiseAhaError
        builder.use FaradayMiddleware::FollowRedirects
        builder.use FaradayMiddleware::Mashify

        builder.use FaradayMiddleware::ParseJson, :content_type => /\bjson$/

        faraday_config_block.call(builder) if faraday_config_block

        builder.headers[:user_agent] = user_agent
        builder.adapter *adapter
      end
    end
  end
end
