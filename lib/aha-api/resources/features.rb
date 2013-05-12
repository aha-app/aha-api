module AhaApi
  class Resource
    module Features

      # Create an issue for a repository
      #
      # @param repo [String, Repository, Hash] A GitHub repository
      # @param title [String] A descriptive title
      # @param body [String] A concise description
      # @param options [Hash] A customizable set of options.
      # @option options [String] :assignee User login.
      # @option options [Integer] :milestone Milestone number.
      # @option options [String] :labels List of comma separated Label names. Example: <tt>bug,ui,@high</tt>.
      # @return [Issue] Your newly created issue
      # @see http://developer.github.com/v3/issues/#create-an-issue
      # @example Create a new Issues for a repository
      #   Octokit.create_issue("sferik/rails_admin", 'Updated Docs', 'Added some extra links')
      def create_feeature(repo, title, body, options={})
        post("repos/#{Repository.new(repo)}/issues", options.merge({:title => title, :body => body}))
      end

      # Get a single issue from a repository
      #
      # @param repo [String, Repository, Hash] A GitHub repository
      # @param number [String] Number ID of the issue
      # @return [Issue] The issue you requested, if it exists
      # @see http://developer.github.com/v3/issues/#get-a-single-issue
      # @example Get issue #25 from pengwynn/octokit
      #   Octokit.issue("pengwynn/octokit", "25")
      def feature(repo, number, options={})
        get("repos/#{Repository.new(repo)}/issues/#{number}", options)
      end

    end
  end
end
