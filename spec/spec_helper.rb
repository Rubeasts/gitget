# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require 'vcr'
require 'webmock'

require_relative '../lib/gitget'

FIXTURES_FOLDER = 'spec/fixtures'
CASSETTES_FOLDER = "#{FIXTURES_FOLDER}/cassettes"
DEVELOPER = 'developer'
REPOSITORY = 'repository'

USERNAME = 'rjollet'
SAD_USERNAME = '12547'

HAPPY_OWNER = 'rjollet'
HAPPY_REPO = 'DeepViz'

SAD_OWNER = '12547'
SAD_REPO = '12547'

if File.file?('config/github_credential.yml')
  credentials = YAML.load(File.read('config/github_credential.yml'))
  ENV['GH_USERNAME'] = credentials[:username]
  ENV['GH_TOKEN'] = credentials[:token]
  ENV['GH_AUTH'] = credentials[:auth]
end

VCR.configure do |c|
  c.cassette_library_dir = CASSETTES_FOLDER
  c.hook_into :webmock

  c.filter_sensitive_data('<AUTH>') { ENV['GH_AUTH'] }
end
