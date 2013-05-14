module AhaApi
  class Resource
    module IntegrationFields

      def create_integration_field(feature_ref, integration, name, value, options={})
        post("api/#{api_version}/features/#{feature_ref}/integrations/#{integration}/fields", 
          :integration_field => options.merge({:name => name, :value => value}))
      end

      def integration_field(feature_ref, integration, field_name, options={})
        get("api/#{api_version}/features/#{feature_ref}/integrations/#{integration}/fields/#{field_name}", options)
      end

    end
  end
end
