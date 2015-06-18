Rails.application.routes.draw do
  root                'static_pages#home'
  get    'help'    => 'static_pages#help'
  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  get    'demo'    => 'users#show'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :characters, param: :slug do
    get 'minus_experience', on: :member
    get 'plus_experience', on: :member
    get 'toggle_loss', on: :member
    get 'open_text', on: :member
  end 

  resources :fate do
    get 'use', on: :member
    get 'plus', on: :member
  end

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  # resources :microposts,          only: [:create, :destroy]
  # resources :relationships,       only: [:create, :destroy]
end

#characters
  #view
  