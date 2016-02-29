Rails.application.routes.draw do
  namespace :v1 do
    resources :users, only: [:create, :show, :update] do
      post 'login', on: :collection
    end
  end
end