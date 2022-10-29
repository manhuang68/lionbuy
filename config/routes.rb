Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  get 'similar_movies/:title' => 'movies#search', as: :search_similar_movie
  get 'signup/' => 'movies#signup', as: :signup
  get 'signin/' => 'movies#signin', as: :signin
end
