# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] ||= "cucumber"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'cucumber/rails/world'
require 'cucumber/formatter/unicode'
require 'webrat'
require 'cucumber/webrat/element_locator' # Lets you do table.diff!(element_at('#my_table_or_dl_or_ul_or_ol').to_table)
Webrat.configure do |config|
  config.mode = :rails
end
require 'cucumber/rails/rspec'
require 'webrat/core/matchers'

require File.dirname(__FILE__) + '/../../spec/blueprints'
