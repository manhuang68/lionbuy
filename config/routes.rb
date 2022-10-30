Rottenpotatoes::Application.routes.draw do
  # resources :movies
  # # map '/' to be a redirect to '/movies'
  # root :to => redirect('/movies')
  # get 'similar_movies/:title' => 'movies#search', as: :search_similar_movies

  resources :posts
  # map '/' to be a redirect to '/movies'

  root :to => redirect('/posts')
  get '/signup' => 'users#signup', as: :signup
  get '/signin' => 'users#index', as: :signin

  post '/users' => 'users#create'

  post '/sessions' => 'sessions#create'

  get '/logout' => 'sessions#destroy', as: :signout
end
