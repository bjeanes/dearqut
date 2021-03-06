require 'active_record'
require 'model_hacks'
require 'authlogic'
require 'acts_as_taggable_helper'
require 'acts_as_taggable_redux'
require File.join(RAILS_ROOT, 'vendor', 'plugins', 'acts_as_snook', 'init')

%w(vote user message).each do |model|
  require File.join(RAILS_ROOT, "app", "models", model)
end

def last_tweet
  l = Message.maximum(:tweet_id, :conditions => "tweet_id IS NOT NULL")
  l == 0 ? 1 : l
end

config = YAML.load_file(File.join(RAILS_ROOT, "config", "database.yml"))[RAILS_ENV]

ActiveRecord::Base.establish_connection(config)