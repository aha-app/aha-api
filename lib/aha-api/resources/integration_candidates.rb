module AhaApi
  class Resource
    module IntegrationCandidates

      def integration_candidates(options={})
        get("api/#{api_version}/integration_candidates", options)
      end

      def create_integration_candidate(options={})
        post("api/#{api_version}/integration_candidates", options)
      end

      def update_integration_candidate(id, options={})
        put("api/#{api_version}/integration_candidates/#{id}", options)
      end

    end
  end
end
