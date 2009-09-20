require 'net/http'
require 'uri'
class KeywordFinder
  
  class << self
    def get_keywords(string)
      Net::HTTP.post_form(URI.parse('http://localhost:8000/'), string).body.split(/:/)
    end
  end
  
end