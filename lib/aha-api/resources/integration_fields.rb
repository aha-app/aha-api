module AhaApi
  class Resource
    module IntegrationFields

      def create_integration_field(resource_type, resource_id, integration, name, value, options={})
        post("api/#{api_version}/#{resource_type}/#{resource_id}/integrations/#{integration}/fields", 
          options.merge(:integration_field => {:name => name, :value => value}))
      end
      
      def create_integration_fields(resource_type, resource_id, integration, fields, options={})
        post("api/#{api_version}/#{resource_type}/#{resource_id}/integrations/#{integration}/fields", 
          options.merge(:integration_fields => fields.map {|k,v| {name: k, value: v} }))
      end

      def integration_field(resource_type, resource_id, integration, field_name, options={})
        get("api/#{api_version}/#{resource_type}/#{resource_id}/integrations/#{integration}/fields/#{field_name}", options)
      end

      def search_integration_fields(integration, field_name, field_value, options={})
        get("api/#{api_version}/integrations/#{integration}/fields/#{field_name}/value/#{field_value}", options)
      end
      
      def adjacent_integration_fields(resource_type, resource_id, integration, options={})
        get("api/#{api_version}/#{resource_type}/#{resource_id}/integrations/#{integration}/adjacent_fields", options)
      end
      
    end
  end
end
