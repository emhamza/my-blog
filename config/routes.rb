Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'users#index'

  get '/users', to: 'users#index'

  get '/users/:id', to: 'users#show',as: 'user'

  get '/users/:id/posts', to: 'posts#index', as: 'user_posts'

  get '/users/:id/posts/new', to: 'posts#new'

  get '/users/:id/posts/:post_id', to: 'posts#show',  as: 'post'

  post '/users/:id/posts/create', to: 'posts#create'

  get '/users/:id/posts/:post_id/comments/new', to: 'comments#new'

  post '/users/:id/posts/:post_id/comments/create', to: 'comments#create'

  post '/users/:id/posts/:post_id/likes/create', to: 'likes#create'

end
