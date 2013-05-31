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

      def search_integration_fields(integration, field_name, field_value, options={})
        get("api/#{api_version}/integrations/#{integration}/fields/#{field_name}/value/#{field_value}", options)
      end


    end
  end
end
