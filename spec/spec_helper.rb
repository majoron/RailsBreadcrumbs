ENV["RAILS_ENV"] = "test"
require 'rubygems'
require 'rspec'
require 'action_controller'

module Rails
  module VERSION
    MAJOR = 3
  end
end unless defined? Rails

$:.unshift File.dirname(__FILE__)
$:.unshift File.join(File.dirname(__FILE__), '../lib')

require 'rails_breadcrumbs'

# SimpleNavigation.root = './'
RAILS_ROOT = './' unless defined?(RAILS_ROOT)
RAILS_ENV = 'test' unless defined?(RAILS_ENV)

RSpec.configure do |config|
  config.mock_with :rspec
end

