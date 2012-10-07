Clipster::Engine.routes.draw do
  #/clipster route
  # root :to => "application#index"

  resources :clips, :path => "/"
end
