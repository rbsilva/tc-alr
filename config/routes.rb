TC::Application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :users
    resources :roles
    resources :dimensions
    resources :facts
    get "inbound/list"
    get "data_warehouse/list"
  end

  resources :upload, :as => :raw_files, :controller => :raw_files do
    member do
      get :download
    end
    collection do
      post :search
    end
  end

  get "home/index"

  root :to => 'home#index'
end
