Clipster::Engine.routes.draw do

  resources :users, :only => :show
  resources :about, :only => :index

  resources :clips, :path => "/", :only=> [:create, :new, :show] do
    collection do
      get 'search'
      get 'clips'
    end
  end

  root :to => "clips#new"
end
