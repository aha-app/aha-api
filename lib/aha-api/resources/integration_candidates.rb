module AhaApi
  class Resource
    module IntegrationCandidates

      def create_integration_candidate(options={})
        post("api/#{api_version}/integration_candidates", options.merge({:name => name, :description => description}))
      end

      def integration_candidates(options={})
        get("api/#{api_version}/integration_candidates", options)
      end

    end
  end
end
