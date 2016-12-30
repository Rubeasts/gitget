# frozen_string_literal: true

module  Github
  # Main class to set up a Github User
  class Repository
    attr_reader :id, :name, :full_name, :is_private, :is_fork, :created_at,
                :updated_at, :pushed_at, :size, :stargazers_count,
                :watchers_count, :has_issues, :has_downloads, :forks_count,
                :open_issues_count, :forks, :open_issues, :watchers, :language,
                :git_url

    def initialize(data: nil)
      load_data(data)
    end

    def stats
      return @stats if @stats

      @stats = {}
      stats_promise = {}

      stats_array = [
        'contributors',
        'commit_activity',
        'code_frequency',
        'participation',
        'punch_card']

      stats_array.each do |stat|
        stats_promise[stat] = Concurrent::Promise.execute {
          Github::API.repo_stat(@full_name, stat)
        }
      end

      stats_promise.each do |stat_name, stat_value|
        @stats[stat_name] = stat_value.value
      end
      @stats
    end

    def load_data(repo_data)
      @id = repo_data['id']
      @full_name = repo_data['full_name']
      @is_private = repo_data['is_private']
      @is_fork = repo_data['is_fork']
      @created_at = repo_data['created_at']
      @pushed_at = repo_data['pushed_at']
      @size = repo_data['size']
      @stargazers_count = repo_data['stargazers_count']
      @watchers_count = repo_data['watchers_count']
      @forks_count = repo_data['forks_count']
      @open_issues_count = repo_data['open_issues_count']
      @language = repo_data['language']
      @git_url = repo_data['git_url']
    end

    def self.find(owner:, repo:)
      repo_data = Github::API.repo_info(owner, repo)
      return nil if repo_data['message'] == 'Not Found'
      new(data: repo_data)\
    end
  end
end
