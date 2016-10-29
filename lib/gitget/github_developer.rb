require_relative 'github_api'
require_relative 'github_repository'

module  Github
  # Main class to set up a Github User
  class Developer
    attr_reader :name, :id, :public_repos, :followers, :following

    def initialize(data:)
      @name = data['login']
      @id = data['id']
      @public_repos = data['public_repos']
    end

    def repos
      return @repos if @repos

      @repos = Github::API.user_repos(@name).map do |repo_data|
        Github::Repository.new(data: repo_data)
      end
    end

    def followers
      return @followers if @followers

      @followers = Github::API.user_followers @name
    end

    def following
      return @following if @following

      @following = Github::API.user_following @name
    end

    def self.find(username:)
      user_data = Github::API.user_info(username)
      new(data: user_data)
    end
  end
end
