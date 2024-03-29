Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  post 'search', to: 'search#search', as: 'search'
  get 'my_trails', to: 'trails#my_trails', as: 'my_trails'

  resources :trails do
    resources :followers, only: [:create]
    resources :video_contents, only: [:new, :create]
    resources :reviews, only: [:new, :create]
  end

  resources :video_contents, only:[:show,:destroy]
  resources :meetings, only: :index
  resources :followers, only: [:destroy]

  resources :meetings, only: [:index, :new, :create, :edit, :update, :destroy] do
    collection do
      get "weekly"
      get "monthly"
    end
  end
end
