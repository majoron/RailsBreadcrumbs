$:.unshift File.dirname(__FILE__)
$:.unshift File.join(File.dirname(__FILE__), '../lib')

ENV["RAILS_ENV"] = "test"
require 'rubygems'
require 'rspec'
require 'action_controller'
require 'rails_breadcrumbs'

module Rails
  module VERSION
    MAJOR = 3
  end
end unless defined? Rails

# RailsBreadcrumbs.root = './'
RAILS_ROOT = './' unless defined?(RAILS_ROOT)
RAILS_ENV = 'test' unless defined?(RAILS_ENV)

RSpec.configure do |config|
  config.mock_with :rspec
end

