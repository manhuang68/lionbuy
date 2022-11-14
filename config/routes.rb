Rottenpotatoes::Application.routes.draw do
  resources :posts
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/posts')
  get '/signup' => 'users#signup', as: :signup
  get '/signin' => 'users#index', as: :signin
  post '/users' => 'users#create', as: :register
  post '/sessions' => 'sessions#create', as: :login
  get '/logout' => 'sessions#destroy', as: :signout
  get '/posts' => 'users#update', as: :users

  # bidding
  post '/bids' => 'bids#create', as: :bidding
  get '/bids/history/:id' => 'bids#history', as: :bid_history

  # user history
  get '/history/buy' => 'history#buy', as: :order_history
  get '/history/sell' => 'history#sell', as: :selling_history
end
