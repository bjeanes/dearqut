# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  github    = "http://gems.github.com"
  gemcutter = 'http://gemcutter.org'
  
  deps = [
    ["haml",               "2.2.9"],
    ["json",               "1.1.9"],
    ["twitter",            "0.6.15"],
    ["mbbx6spp-twitter4r", "0.4.0", {:source => github, :lib => false}],
    ["twibot",             "0.1.7", {:lib => false}],
    ["chronic",            "0.2.3"],
    ["whenever",           "0.3.7", {:lib => false}],
    ["formtastic",         "0.2.5"],
    ["rack-tidy",          "0.2.0", {:lib => 'rack/tidy'}]
  ].each do |gem, version, options|
    options ||= {}
    options[:version] = version
    options = {:source => gemcutter}.merge(options)
    config.gem(gem, options)
  end
  
  config.middleware.use            "Rack::Tidy"  
  config.time_zone               = 'Brisbane'
  config.active_record.observers = :activity_observer
end

ActiveRecord::Base.include_root_in_json = false

require 'aatr_ext'
require 'active_record_errors_ext'
require 'tidy'
