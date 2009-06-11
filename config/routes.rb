ActionController::Routing::Routes.draw do |map|
  map.resources :users, :tags
  
  map.resources(:messages, :member => {:add_context => :get}, :collection => {:random => :get, :popular => :get}) do |mes|
    mes.resources :comments
    mes.resource  :vote, :member => {:up => :post, :down => :post}, :only => []
  end
  map.resources(:site, :collection => {:about => :get, :help=>:get, :privacy=>:get, :contact=>:get})
  
  map.signup '/signup', :controller => "users", :action => "new"
  map.twitter_login '/login/twitter', :controller => "sessions", :action => "new", :twitter => true
  
  map.root :controller => "messages", :action => "new"
end
