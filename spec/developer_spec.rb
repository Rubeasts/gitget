# frozen_string_literal: true

require_relative 'spec_helper'

describe 'Github specifications' do

  before do
    VCR.insert_cassette DEVELOPER, record: :new_episodes
    @developer = Github::Developer.find(username: USERNAME)
    @sad_developer = Github::Developer.find(username: SAD_USERNAME)
  end

  after do
    VCR.eject_cassette
  end

  it 'should return nil for no developer found' do
    @sad_developer.must_be_nil
  end

  it 'should be able to open a new Github Developer' do
    @developer.username.length.must_be :>, 0
  end

  it 'should get the user id' do
    @developer.id.must_be :>, 0
  end

  it 'should get the number of public repos' do
    @developer.public_repos.must_be :>, 0
  end

  it 'should get the followers' do
    @developer.followers.length.must_be :>, 0
  end

  it 'should get the following' do
    @developer.following.length.must_be :>=, 0
  end

  it 'should get the repos' do
    @developer.repos.length.must_be :>, 0
  end

  it 'should get the repo should have a full name' do
    @developer.repos.first.full_name.must_be_instance_of String
  end

  it 'should get the repo should have stats' do
    @developer.repos.first.stats.wont_be_nil
  end
end
