# frozen_string_literal: true

module  Github
  # Main class to set up a Github User
  class Developer
    attr_reader :username, :id, :public_repos, :avatar_url, :name, :company,
                :blog, :location, :email, :bio, :followers, :following

    def initialize(data: nil)
      load_data(data)
    end

    def repos
      return @repos if @repos

      repos_promises = Github::API.user_repos(@username).map do |repo_data|
          Concurrent::Promise.execute {Github::Repository.new(data: repo_data)}
      end
      @repos = repos_promises.map(&:value)
      @repos
    end

    def followers
      return @followers if @followers

      @followers = Github::API.user_followers @username
    end

    def following
      return @following if @following

      @following = Github::API.user_following @username
    end

    def starred
      return @starred if @starred

      @starred = Github::API.user_starred @username
    end

    def load_data(repo_data)
      @username = repo_data['login']
      @id = repo_data['id']
      @public_repos = repo_data['public_repos']
      @avatar_url = repo_data['avatar_url']
      @name = repo_data['name']
      @company = repo_data['company']
      @blog = repo_data['blog']
      @location = repo_data['location']
      @email = repo_data['email']
      @bio = repo_data['bio']
    end

    def self.find(username:)
      user_data = Github::API.user_info(username)
      return nil if user_data['message'] == 'Not Found'
      new(data: user_data)
    end
  end
end
