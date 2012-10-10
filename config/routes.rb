Clipster::Engine.routes.draw do
  #/clipster route
  
  resources :clips, :path => "/" do
    collection do
      get 'list', :action => :list
      get 'list(/:lang)', :action => :list
    end
  end

  root :to => :clips
end
