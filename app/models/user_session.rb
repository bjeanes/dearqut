class UserSession < Authlogic::Session::Base
  def self.oauth_consumer
    key    = TwitterAuth["oauth_consumer_key"]
    secret = TwitterAuth["oauth_consumer_secret"]
    base   = TwitterAuth["base_url"]
    path   = TwitterAuth["authorize_path"]
    url    = "#{base}#{path}"
    options = { :site => base, :authorize_url => url }

    OAuth::Consumer.new(key, secret, options)
  end
end
