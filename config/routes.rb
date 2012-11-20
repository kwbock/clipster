Clipster::Engine.routes.draw do

  resources :users, :only => :show
  #/clipster route

  resources :clips, :path => "/" do
    collection do
      get 'list', :action => :list
      get 'list(/:lang)(.:format)', :action => :list
      get 'search', :action => :search
      get 'about', :action => :about
    end
  end

  root :to => :clips
end
