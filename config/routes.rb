Rails.application.routes.draw do
  get "/user", to: "users#show"
  post '/user', to: 'users#create'
  put '/user', to: 'users#update'
  delete '/user', to: 'users#destroy'

  post '/posts/:post_id/like', to: 'likes#post_like'
  post '/posts/:post_id/comments/:comment_id/like', to: 'likes#comment_like'
  delete '/posts/:post_id/like/:id', to: 'likes#unlike_post'
  delete '/posts/:post_id/comments/:comment_id/like/:id', to: 'likes#unlike_comment'

  post "/login", to: "users#login"
  root("posts#index")

  resources :posts, except: %i(new edit) do
    resources :comments, except: %i(new edit)
  end

  post("/posts/:id/tag",  to: "posts#link_tag")
  delete("/posts/:id/tag",  to: "posts#unlink_tag")
  get("/posts/:id/tags",  to: "posts#show_tags")

  resources :tags, except: %i[ new edit ]

end