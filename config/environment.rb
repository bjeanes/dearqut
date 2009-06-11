# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # config.load_paths += %W( #{RAILS_ROOT}/extras )
  config.gem 'json'
  config.gem 'twitter'
  config.gem 'twitter-auth', :lib => 'twitter_auth', :version => "~> 0.1.21"

  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'Brisbane'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
end

ActiveRecord::Base.include_root_in_json = false
require 'aatr_ext'