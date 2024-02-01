Rails.application.routes.draw do
  
  root to: 'home#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }#controllers以下あるとエラー
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get 'users/profile'
  get 'users/profile_edit'
  get 'users' => 'users#dummy'
  resources:users
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
