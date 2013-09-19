module AhaApi
  class Resource
    module IntegrationFields

      def create_integration_field(resource_ref, integration, name, value, options={})
        post("api/#{api_version}/#{resource_type(resource_ref)}/#{resource_ref}/integrations/#{integration}/fields", 
          :integration_field => options.merge({:name => name, :value => value}))
      end

      def integration_field(resource_ref, integration, field_name, options={})
        get("api/#{api_version}/#{resource_type(resource_ref)}/#{resource_ref}/integrations/#{integration}/fields/#{field_name}", options)
      end

      def search_integration_fields(integration, field_name, field_value, options={})
        get("api/#{api_version}/integrations/#{integration}/fields/#{field_name}/value/#{field_value}", options)
      end

    protected
      def resource_type(resource_ref)
        if resource_ref =~ /-R-\d+$/ or resource_ref =~ /-R-PL$/
          "releases"
        elsif resource_ref =~ /-\d+-\d+$/
          "requirements"
        else
          "features"
        end
      end
    end
  end
end
