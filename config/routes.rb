Rails.application.routes.draw do
  resources :contacts
  get 'sessions/new'

  get '/blogs/top', to: 'blogs#top'
  resources :blogs do
    collection do
      post :confirm
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :favorites, only: [:create, :destroy]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # /letter_openerのURLにアクセスした時、下記のようなメール送信BOXが出現
end
