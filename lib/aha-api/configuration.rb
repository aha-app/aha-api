require 'faraday'
require 'logger'
require 'aha-api/version'

module AhaApi
  module Configuration
    VALID_OPTIONS_KEYS = [
      :domain,
      :adapter,
      :faraday_config_block,
      :api_version,
      :url_base,
      :api_endpoint,
      :login,
      :password,
      :oauth_token,
      :proxy,
      :user_agent,
      :logger].freeze

    DEFAULT_ADAPTER = Faraday.default_adapter
    DEFAULT_API_VERSION = "v1"
    DEFAULT_URL_BASE = "https://aha.io/"
    DEFAULT_USER_AGENT = "Aha! API Ruby Gem #{AhaApi::VERSION}".freeze

    attr_accessor(*VALID_OPTIONS_KEYS)

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def options
      VALID_OPTIONS_KEYS.inject({}){|o,k| o.merge!(k => send(k)) }
    end

    def api_endpoint
      u = URI(@url_base.to_s)
      if not (u.host =~ /[a-z0-9-]+\.[a-z0-9-]+\.[a-z0-9-]+/)
        u.host = "#{@domain}.#{u.host}"
      end
      u.to_s
    end

    def faraday_config(&block)
      @faraday_config_block = block
    end

    def reset
      self.logger              = Logger.new(STDOUT)
      self.logger.level        = Logger::DEBUG
      self.domain              = nil
      self.adapter             = DEFAULT_ADAPTER
      self.api_version         = DEFAULT_API_VERSION
      self.url_base            = DEFAULT_URL_BASE
      self.proxy               = nil
      self.login               = nil
      self.password            = nil
      self.oauth_token         = nil
      self.user_agent          = DEFAULT_USER_AGENT
    end
  end
end
