# frozen_string_literal: true
require 'rake/testtask'

task default: :spec

Rake::TestTask.new(:spec) do |t|
  t.pattern = 'spec/*_spec.rb'
  t.warning = false
end

namespace :credentials do
  require 'yaml'

  desc 'Export sample credentials from file to bash'
  task :export do
    credentials = YAML.load(File.read('config/github_credential.yml'))
    puts 'Please run the following in bash:'
    puts "export GH_USERNAME=#{credentials[:username]}"
    puts "export GH_TOKEN=#{credentials[:token]}"
  end
end

desc 'delete cassette fixtures'
task :wipe do
  sh 'rm spec/fixtures/cassettes/*.yml' do |ok, _|
    puts(ok ? 'Cassettes deleted' : 'No casseettes found')
  end
end

namespace :quality do
  desc 'run all quality checks'
  task all: [:rubocop, :flog, :flay]

  task :flog do
    sh 'flog lib/'
  end

  task :flay do
    sh 'flay lib/'
  end

  task :rubocop do
    sh 'rubocop'
  end
end
