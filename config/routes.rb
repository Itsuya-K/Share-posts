Rails.application.routes.draw do
  get 'sessions/new'

  get '/blogs/top' ,to: 'blogs#top'
  resources :blogs do
    collection do
      post :confirm
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :favorites, only: [:create, :destroy]
end
