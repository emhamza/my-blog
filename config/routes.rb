Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'users#index'

  get '/users', to: 'users#index'

  get '/users/:id', to: 'users#show'

  get '/users/:id/posts', to: 'users#index'

  get '/users/:id/posts/:post_id', to: 'users#show'

end
