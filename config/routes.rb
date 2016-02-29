Rails.application.routes.draw do
  namespace :v1 do

    resources :users, except: [:new, :edit, :index] do
      post 'login', on: :collection
    end

    resources :drivers, except: [:new, :edit, :index] do
      post 'login', on: :collection
    end
  end
end