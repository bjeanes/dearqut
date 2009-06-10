unless defined? ActionView::Base
  module ActionView
    class Base
      # Just here for acts_as_taggable to not fail
    end
  end
end

class ActiveRecord::Base
  def logger; $logger; end
  def self.logger; $logger; end
end

unless defined? TwitterAuth::GenericUser
  module TwitterAuth
    class GenericUser < ActiveRecord::Base
      # Hack to get the User model to load
      def self.table_name; 'users' end
    end
  end
end