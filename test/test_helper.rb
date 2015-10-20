ENV["RAILS_ENV"] = "test"
require "codeclimate-test-reporter"
require "rack_session_access/capybara"
require 'mock_redis'

CodeClimate::TestReporter.start

require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

# Disable sphinx deltas by default. Enable it again in the tests when needed
require 'thinking_sphinx'
ThinkingSphinx::Deltas.suspend!

require "minitest/reporters"
Minitest::Reporters.use!(
    Minitest::Reporters::ProgressReporter.new,
    ENV,
    Minitest.backtrace_filter
)

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  fixtures :all
end

class ActionController::TestCase
  include Devise::TestHelpers
end

Capybara.asset_host = "http://localhost:3000"
#require "custom_email_assertions"

#OmniAuth.config.test_mode = true

#CarrierWave.root = 'test/fixtures/files'

#Phantomjs installation if not found
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, :phantomjs => Phantomjs.path)
end