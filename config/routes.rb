Clipster::Engine.routes.draw do

  resources :users, :only => :show
  resources :about, :only => :index

  resources :clips, :path => "/", :only=> [:new, :show] do
    collection do
      get 'search'
      get 'clips'
      post 'create', :path=> "create", :as=> "create"
    end
    post 'preview', on: :new
  end

  root :to => "clips#new"
end
