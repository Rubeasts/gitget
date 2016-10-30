# frozen_string_literal: true

module  Github
  # Main class to set up a Github User
  class Repository
    attr_reader :id, :name, :full_name, :is_private, :is_fork, :created_at,
                :updated_at, :pushed_at, :size, :stargazers_count,
                :watchers_count, :has_issues, :has_downloads, :forks_count,
                :open_issues_count, :forks, :open_issues, :watchers

    def initialize(data: nil)
      load_data(data)
    end

    def stats
      return @stats if @stats

      @stats = {}
      %w(
        contributors commit_activity code_frequency participation punch_card
      ).each do |stat|
        @stats[stat] = Github::API.repo_stat(@full_name, stat)
      end
    end

    def load_data(repo_data)
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
    end
  end
end
