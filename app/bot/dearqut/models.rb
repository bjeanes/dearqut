require 'active_record'

unless defined? TwitterAuth::GenericUser
  module TwitterAuth
    class GenericUser < ActiveRecord::Base
      # Hack to get the User model to load
      def self.table_name; 'users' end
      def self.acts_as_tagger; end
    end
  end
end

Dir[File.join(RAILS_ROOT, "app", "models", "*.rb")].each do |model|
  require model
end

def last_tweet
  Message.maximum(:tweet_id, :conditions => "tweet_id IS NOT NULL")
end

config = YAML.load_file(File.join(RAILS_ROOT, "config", "database.yml"))[RAILS_ENV]

ActiveRecord::Base.establish_connection(config)