existing_proxies = ActionController::Request::TRUSTED_PROXIES.inspect.sub(/^\/(.*)\/i$/, '\1')
new_proxies      = %w(^131\.181\.251\.67$).join('|')

ActionController::Request.const_set('TRUSTED_PROXIES', 
  Regexp.new("#{new_proxies}|#{existing_proxies}",'i'))
