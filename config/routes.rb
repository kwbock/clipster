Clipster::Engine.routes.draw do
  #/clipster route
  
  resources :clips, :path => "/" do
    collection do
      get "list/(:lang)", :action => "list"
    end
  end

  root :to => :clips
end
