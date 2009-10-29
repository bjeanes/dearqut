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