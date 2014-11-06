module AhaApi
  class Resource
    module Ideas

      def create_idea(product_id, name, description, options={})
        post("api/#{api_version}/products/#{product_id}/ideas", options.merge({:name => name, :description => description}))
      end

    end
  end
end
