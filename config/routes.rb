# config/routes.rb
Rails.application.routes.draw do
  get '/new', to: 'games#new'
  get '/score', to: 'games#score'
  post '/score', to: 'games#score'
  get '/result', to: 'games#result'

  # Define the root path route ("/")
  # root "articles#index"
end
