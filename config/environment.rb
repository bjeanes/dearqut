# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  github    = "http://gems.github.com"
  gemcutter = 'http://gemcutter.org'
  
  config.gem 'haml'
  config.gem 'json'
  config.gem 'twitter'
  config.gem 'twitter-auth',       :lib => 'twitter_auth', :version => "~> 0.1.21"
  config.gem 'mbbx6spp-twitter4r', :lib => false,          :source => github
  config.gem 'twibot',             :lib => false,          :version => '= 0.1.7'
  config.gem 'javan-whenever',     :lib => false,          :source => github
  config.gem 'formtastic',         :version => '>= 0.2.5', :source => gemcutter
  config.gem 'tidy'
  config.gem 'rack-tidy',          :lib => 'rack/tidy',    :source => gemcutter

  config.middleware.use "Rack::Tidy"
  
  config.active_record.observers = :activity_observer
  
  config.time_zone = 'Brisbane'
end

ActiveRecord::Base.include_root_in_json = false

require 'aatr_ext'
require 'active_record_errors_ext'
require 'tidy'
