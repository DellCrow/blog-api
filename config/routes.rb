Rails.application.routes.draw do
  resources :users
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root("posts#index")
  # get("/posts", to: "posts#index")
  # post("/posts", to: "posts#create")
  # get("/posts/:id", to: "posts#show")
  # patch("/posts/:id", to: "posts#update")
  # put("/posts/:id", to: "posts#update")
  # delete("/posts/:id", to: "posts#destroy")

  resources :posts, except: %i[ new edit ] do
    resources :comments, except: %i[ new edit ]
  end
  post("/posts/:id/tag",  to: "posts#link_tag")
  delete("/posts/:id/tag",  to: "posts#unlink_tag")
  get("/posts/:id/tags",  to: "posts#show_tags")

  resources :tags, except: %i[ new edit ]

  # get("/tags", to: "tags#index")
  # post("/tags", to: "tags#create")
  # get("/tags/:id", to: "tags#show")
  # patch("/tags/:id", to: "tags#update")
  # put("/tags/:id", to: "tags#update")
  # delete("/tags/:id", to: "tags#destroy")

end
