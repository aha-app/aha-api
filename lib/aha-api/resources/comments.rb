module AhaApi
  class Resource
    module Comments

      def create_comment(commentable_type, commentable_id, email, body, options={})
        post("api/#{api_version}/#{commentable_type}/#{commentable_id}/comments", 
          :comment => options.merge({:user_email => email, :body => body}))
      end
      
      def create_comment_with_url(object_url, email, body, options={})
        post("#{object_url}/comments", 
          :comment => options.merge({:user_email => email, :body => body}))
      end

      def comments(commentable_type, commentable_id, options={})
        get("api/#{api_version}/#{commentable_type}/#{commentable_id}/comments", options)
      end

    end
  end
end
