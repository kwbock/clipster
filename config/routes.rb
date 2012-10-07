Clipster::Engine.routes.draw do
  #/clipster route
  resources :clips, :path => "/"
  root :to => :clips
end
