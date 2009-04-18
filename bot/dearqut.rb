RAILS_ENV  = ENV['RAILS_ENV'] || "development"
RAILS_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..')) unless defined?(RAILS_ROOT)
$:.unshift(File.join(File.dirname(__FILE__), "lib"))

require 'pid'
require 'rubygems'
require 'models'
require 'handler'
require 'bot'
