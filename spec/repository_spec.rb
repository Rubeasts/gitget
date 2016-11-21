# frozen_string_literal: true

require_relative 'spec_helper'

describe 'Github specifications' do

  before do
    VCR.insert_cassette REPOSITORY, record: :new_episodes
    @repository = Github::Repository.find(owner: HAPPY_OWNER, repo: HAPPY_REPO)
    @sad_repository = Github::Repository.find(owner: SAD_USERNAME, repo: SAD_REPO)
  end

  after do
    VCR.eject_cassette
  end

  it 'should return nil for no repository found' do
    @sad_repository.must_be_nil
  end

  it 'should be able to open a new Github Repository' do
    @repository.full_name.must_be_instance_of String
  end

  it 'should get the repository id' do
    @repository.id.must_be :>, 0
  end

  it 'should get the repo should have stats' do
    @repository.stats.wont_be_nil
  end
end
