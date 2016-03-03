Rails.application.routes.draw do
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