Rails.application.routes.draw do
  get 'tweet/index'
  devise_for :users
  root to: "tweet#index"
  resources :tweet, only: [:index] do
    collection do
      post :create_tweet
    end
  end
  resources :user, only: [:show] do
    collection do
      post :follow
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
