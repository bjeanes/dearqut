ActionController::Routing::Routes.draw do |map|
  map.resources :comments

  map.resources :messages

  map.resources :votes

  map.resources :votes
  map.resources :comments
  map.resources :messages
  map.resources :users
  
  map.signup '/signup', :controller => "users", :action => "new"
  map.twitter_login '/login/twitter', :controller => "sessions", :action => "new", :twitter => true
  map.root :controller => "messages", :action => "new"
end
