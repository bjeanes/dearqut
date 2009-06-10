RAILS_ENV  = ENV['RAILS_ENV'] || "development"
RAILS_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..','..')) unless defined?(RAILS_ROOT)
$:.unshift(File.join(File.dirname(__FILE__), "dearqut"))
$:.unshift(File.join(RAILS_ROOT, 'vendor', 'plugins','acts_as_taggable_redux','lib'))

require 'rubygems'
require 'logger'

$logger = Logger.new('/dev/null')

require 'pid'
require 'models'
require 'handler'
require 'bot'
