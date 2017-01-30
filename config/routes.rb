Rails.application.routes.draw do

  devise_for :users, controllers: {
  registrations: "users/registrations",
  omniauth_callbacks: "users/omniauth_callbacks"
  }

resources :relationships, only: [:create, :destroy]

resources :users, only: [:index, :show] 
root 'top#index'
resources :blogs do
resources :comments

collection do
post :confirm
end
end

resources :contacts, only: [:new, :create] do
collection do
post :confirm
end
end

mount RailsAdmin::Engine => '/admin', as: 'rails_admin'







end