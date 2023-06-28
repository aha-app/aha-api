require 'faraday/follow_redirects'
require 'faraday/mashify'
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

      accept = options.delete(:accept)

      # TODO: Don't build on every request
      Faraday.new(options) do |builder|
        builder.request :json
        builder.request(:authorization, :basic, login, password)

        if accept == 'application/json'
          builder.response :mashify
          builder.response :json
        end

        builder.use Faraday::FollowRedirects::Middleware
        builder.use Faraday::Mashify::Middleware
        builder.use Faraday::Request::Json
        builder.use Faraday::RaiseAhaError::Middleware

        faraday_config_block.call(builder) if faraday_config_block

        builder.headers[:user_agent] = user_agent
        builder.adapter *adapter
      end
    end
  end
end
