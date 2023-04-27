Rails.application.routes.draw do
  post '/auth/session_id', to: 'authentication#post_session_id'

  get '/home', to: 'movies#home'

  resources :users, only: [:show, :update, :create] do
    member do
      post 'logout', to: 'users#logout'
      put 'add_to_watchlist', to: 'users#add_to_watchlist'
      put 'remove_from_watchlist', to: 'users#remove_from_watchlist'
      put 'upload_avatar', to: 'users#upload_avatar'
    end
  end
  post '/users/login', to: 'users#login'

  resources :movies, only: [:index, :show, :update, :create, :new] do
    member do
      get 'videos', to: 'movies#get_videos'
    end
  end

  resources :people, only: [:show]

  resources :movie_reviews, only: [:create, :show, :update]

  resources :static_info, only: [:index]

  get '/search/movies', to: 'search#search_movies'
end
