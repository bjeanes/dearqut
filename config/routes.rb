message_options = {
  :member             => {:delete => :get}, 
  :collection         => {
    :search           => :get,
    :random           => :get, 
    :popular          => :get,
    :most_commented   => :get,
    :latest_commented => :get,
    :controversial    => :get
  }
}

ActionController::Routing::Routes.draw do |map|
  map.resources :users
  map.resources :tags do |tag|
    tag.resources(:messages, message_options)
  end
  
  map.resources(:messages, message_options) do |mes|
    mes.resources :comments
    mes.resource  :vote, :member => {:agree => :post, :disagree => :post}, :only => []
    mes.resources :flags
  end
  
  map.resources(:site, :collection => {:about => :get, :help=>:get, :privacy=>:get, :contact=>:get})
  
  map.login '/login', :controller => "user_sessions", :action => "new"
  map.signup '/signup', :controller => "users", :action => "new"
  
  map.resources :user_sessions
  map.login 'login', :controller => 'user_sessions', :action => 'new'  
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  # map.twitter_login '/login/twitter', :controller => "sessions", :action => "new", :twitter => true
  
  map.namespace :admin do |admin|
    admin.root      :controller => 'dashboard', :action => 'index'
    admin.resources :message_moderation
    admin.resources :staff_accounts, :member => {:approve => :post, :deny => :post}
  end
  
  map.namespace :my do |my|
    my.root :controller => 'accounts', :action => 'redirect_to_show'
    my.activity 'activity', :controller => 'activity', :action => 'index'
    my.resource :account
    my.resources :messages
    my.resources :comments
  end
  
  map.root :controller => "messages", :action => "new"
end
