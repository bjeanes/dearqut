ActionController::Routing::Routes.draw do |map|
  map.resources :users
  map.signup '/signup', :controller => "users", :action => "new"
  map.twitter_login '/login/twitter', :controller => "sessions", :action => "new", :twitter => true
  map.root :controller => "site", :action => "index"
end
