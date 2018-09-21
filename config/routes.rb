Rails.application.routes.draw do
  get '/blogs/top' ,to: 'blogs#top'
  resources :blogs do
    collection do
      post :confirm
    end
  end
end
