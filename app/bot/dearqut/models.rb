require 'active_record'
require 'model_hacks'
require 'acts_as_taggable_helper'
require 'acts_as_taggable_redux'

Dir[File.join(RAILS_ROOT, "app", "models", "*.rb")].each do |model|
  require model
end

def last_tweet
  Message.maximum(:tweet_id, :conditions => "tweet_id IS NOT NULL")
end

config = YAML.load_file(File.join(RAILS_ROOT, "config", "database.yml"))[RAILS_ENV]

ActiveRecord::Base.establish_connection(config)