# frozen_string_literal: true

require 'yaml'
require 'http'
require 'json'

module  Github
  # Service for all Github API call
  class API
    GITHUB_API_URL = 'https://api.github.com'

    def self.config=(credentials)
      @config ? @config.update(credentials) : @config = credentials
    end

    def self.config
      return @config if @config

      @config = { username: ENV['GH_USERNAME'],
                  token:    ENV['GH_TOKEN'] }
    end

    def self.user_info(username)
      route = '/users/' + username
      github_api_get(route)
    end

    def self.repo_info(owner, repo)
      route = '/repos/' + owner + '/' + repo
      github_api_get(route)
    end

    def self.user_followers(username)
      route = '/users/' + username + '/followers'
      github_api_get(route)
    end

    def self.user_following(username)
      route = '/users/' + username + '/following'
      github_api_get(route)
    end

    def self.user_repos(username)
      route = '/users/' + username + '/repos'
      github_api_get(route)
    end

    def self.repo_stat(full_name, stat)
      route = '/repos/' + full_name + '/stats/' + stat
      github_api_get(route)
    end

    private_class_method

    def self.github_api_get_http(url)
      HTTP.basic_auth(user: config[:username], pass: config[:token]).get(url)
    end

    def self.github_api_wait_cache(url)
      response = github_api_get_http(url)
      while response.headers['Status'].split(' ').first == '202'
        sleep(2)
        response = github_api_get_http(url)
      end
      response
    end

    def self.github_api_get(route)
      url = GITHUB_API_URL + route
      response = github_api_wait_cache(url)
      JSON.parse(response.to_s)
    end
  end
end
