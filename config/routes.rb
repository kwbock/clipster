Clipster::Engine.routes.draw do
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
