TC::Application.routes.draw do

  devise_for :users

  namespace :admin do
    resources :users
    resources :roles
    resources :dimensions, :except => [:edit, :update]
    resources :facts, :except => [:edit, :update]
    resources :inbound, :only => :index
    resources :data_warehouse, :only => :index do
      collection do
        post :load
      end
    end
    resources :dashboard, :only => :index
    resources :reports, :except => [:new, :edit]
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
