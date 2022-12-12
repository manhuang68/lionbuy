Rottenpotatoes::Application.routes.draw do

  get '/ajaxtest' => 'posts#ajaxtest', as: :ajaxtest
  resources :posts
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/posts')

  # user
  get '/signup' => 'users#signup', as: :signup
  get '/signin' => 'users#index', as: :signin
  post '/users' => 'users#create', as: :register
  post '/sessions' => 'sessions#create', as: :login
  get '/logout' => 'sessions#destroy', as: :signout
  # get '/posts' => 'users#update', as: :users

  # user history
  get '/history/buy' => 'history#buy', as: :order_history
  get '/history/sell' => 'history#sell', as: :selling_history

  # post
  get '/my_posts' => 'posts#my_posts', as: :poster
  post '/create_posts' => 'posts#create', as: :creatingposter
  get '/edit_post' => "posts#edit"
  post '/update_post' => "posts#update"
  get '/destroy_post' => "posts#destroy"

  # bidding
  post '/bids' => 'bids#create', as: :bidding
  get '/bids/history/:id' => 'bids#history', as: :bid_history

  # Ordering
  post '/ordering' => 'orders#create'
  post '/accept' => 'orders#accept_bid'
  #  get '/order/:id' => 'orders#update'
end
