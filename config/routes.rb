Rails.application.routes.draw do
  root to: "users#new"
  resources :subscribers, only: [:create]
  resources :users, only: [:new, :create, :show]

  namespace :v1 do
    resources :users, except: [:new, :edit, :index] do
      post 'login', on: :collection
    end

    resources :drivers, except: [:new, :edit, :index] do
      post 'login', on: :collection
      get 'nearby_pickups', on: :collection
    end

    resources :pickups, except: [:new, :edit, :index]
  end
end