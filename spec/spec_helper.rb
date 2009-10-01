# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.dirname(__FILE__) + "/../config/environment" unless defined?(RAILS_ROOT)
require 'spec/autorun'
require 'spec/rails'

Spec::Runner.configure do |config|
  config.mock_with :mocha
  
  def freeze_time!
    before do
      now = Time.now
      Time.stubs(:now).returns(now)
    end
  end
end
