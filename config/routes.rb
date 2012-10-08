Clipster::Engine.routes.draw do
  #/clipster route
  
  get "list", :to => "clips#list"
  resources :clips, :path => "/"

  root :to => :clips
end
