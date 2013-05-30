module AhaApi
  class Resource
    module Comments

      def create_comment(commentable_type, commentable_id, body, options={})
        post("api/#{api_version}/#{commentable_type}/#{commentable_id}/comments", 
          :comment => options.merge({:body => body}))
      end

      def comments(commentable_type, commentable_id, options={})
        get("api/#{api_version}/#{commentable_type}/#{commentable_id}/comments", options)
      end

    end
  end
end
