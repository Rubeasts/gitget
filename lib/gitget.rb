# frozen_string_literal: true
require 'concurrent'

files = Dir.glob(File.join(File.dirname(__FILE__), 'gitget/*.rb'))
files.each { |lib| require_relative lib }
