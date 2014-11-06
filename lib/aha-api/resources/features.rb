module AhaApi
  class Resource
    module Features

      def create_feature(name, description, options={})
        post("api/#{api_version}/features", options.merge({:name => name, :description => description}))
      end

      def feature(ref, options={})
        get("api/#{api_version}/features/#{ref}", options)
      end
      
      def update_feature(ref, options = {})
        put("api/#{api_version}/features/#{ref}", options)
      end
    end
  end
end
