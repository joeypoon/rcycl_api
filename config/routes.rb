Rails.application.routes.draw do
  root to: "pages#home"

  namespace :v1 do
    resources :users, except: [:new, :edit, :index] do
      post 'login', on: :collection
    end

    resources :drivers, except: [:new, :edit, :index] do
      post 'login', on: :collection
    end

    resources :subscribers, only: [:create]
    resources :pickups, except: [:new, :edit]
    resources :addresses, except: [:new, :edit]
  end
end
