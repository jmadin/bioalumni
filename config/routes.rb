Biolumni::Application.routes.draw do

  resources :degree_types

  resources :records

  resources :careers do
    resources :records
  end

  resources :degrees

  # resources :alums

  resources :alums do
    resources :degrees
    resources :records
    resources :photos
  end

  resources :photos

  resources :users do
    resources :degrees
  end
  
  resources :sessions,      only: [:new, :create, :destroy]

  get 'tags/:tag', to: 'alums#index', as: :tag

  # root to: 'photos#index'
  
  root to: 'static_pages#home'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
end
