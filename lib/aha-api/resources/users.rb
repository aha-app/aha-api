module AhaApi
  class Resource
    module Users

      def user(user_id, options={})
        get("api/#{api_version}/users/#{CGI.escape(user_id)}", options)
      end
      
    end
  end
end
