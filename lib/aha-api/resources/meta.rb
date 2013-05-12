module AhaApi
  class Resource
    module Meta

      # Get meta information about aha.io, the service.
      #
      # @see http://developer.github.com/v3/meta/
      #
      # @return [Hash] Hash with meta information.
      #
      # @example Get GitHub meta information
      #   @client.github_meta
      def aha_meta(options={})
        get "/meta", options
      end

    end
  end
end
