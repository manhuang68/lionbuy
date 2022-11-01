Rottenpotatoes::Application.routes.draw do
  resources :posts
  # map '/' to be a redirect to '/movies'

  root :to => redirect('/posts')
  get '/signup' => 'users#signup', as: :signup
  get '/signin' => 'users#index', as: :signin
  post '/users' => 'users#create', as: :register
  post '/sessions' => 'sessions#create', as: :login
  get '/logout' => 'sessions#destroy', as: :signout
end
