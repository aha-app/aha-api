require 'multi_json'

module AhaApi
  module Request

    def delete(path, options={})
      request(:delete, path, options).body
    end

    def get(path, options={})
      response = request(:get, path, options).body
    end

    def patch(path, options={})
      request(:patch, path, options).body
    end

    def post(path, options={})
      request(:post, path, options).body
    end

    def put(path, options={})
      request(:put, path, options).body
    end

    private

    # Executes the request, checking if it was successful
    #
    # @return [Boolean] True on success, false otherwise
    def boolean_from_response(method, path, options={})
     request(method, path, options).status == 204
    rescue AhaApi::NotFound
      false
    end

    def request(method, path, options={})
      token = options.delete(:access_token) ||
        options.delete(:oauth_token) ||
        oauth_token

      accept = options.delete(:accept) || 'application/json'
      url = options.delete(:endpoint) || api_endpoint

      conn_options = {
        accept: accept,
        url: url,
      }

      logger.debug("Sending #{method} to #{path}")
      response = connection(conn_options).send(method) do |request|
        request.headers['Accept'] = accept

        if token
          request.headers[:authorization] = "Bearer #{token}"
        end

        case method
        when :get
          request.url(path, options)
        when :delete, :head
          request.url(path, options)
        when :patch, :post, :put
          request.path = path
          request.body = MultiJson.dump(options) unless options.empty?
        end

      end
      logger.debug("  Response: #{response.status}")
      response
    end


  end
end
