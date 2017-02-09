require 'spec_helper'
require 'capybara/rspec'

require_relative '../config/application.rb'

RSpec.configure do |config|

  config.mock_with :rspec
  config.expect_with :rspec
  # config.color_enabled = true
  config.formatter = :documentation
  config.order = 'random'
  config.include Capybara::DSL

end

# This is for checking to see that each endpoint page has the correct information on it
Capybara.configure do |config|
  config.app = App::Controller.new
  config.server_port = 9293
end