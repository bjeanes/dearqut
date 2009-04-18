require 'active_record'

unless defined? TwitterAuth::GenericUser
  module TwitterAuth
    class GenericUser < ActiveRecord::Base
      # Hack to get the User model to load
    end
  end
end

Dir[File.join(RAILS_ROOT, "app", "models", "*.rb")].each do |model|
  require model
end

config = YAML.load(File.read(File.join(RAILS_ROOT, "config", "database.yml")))[RAILS_ENV]

ActiveRecord::Base.establish_connection(config)