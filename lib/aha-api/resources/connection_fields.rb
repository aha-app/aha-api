module AhaApi
  class Resource
    module ConnectionFields

      def create_connection_field(feature_ref, connector_name, name, value, options={})
        post("api/#{api_version}/features/#{feature_ref}/connection/#{connector_name}/fields", options.merge({:name => name, :value => value}))
      end

      def connection_field(feature_ref, connector_name, field_name, options={})
        get("api/#{api_version}/features/#{feature_ref}/connection/#{connector_name}/fields/#{field_name}", options)
      end

    end
  end
end
