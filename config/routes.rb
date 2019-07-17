Rails.application.routes.draw do
  get 'user/:id', to: 'users#show'
  post 'user/create', to: 'users#create'
  post 'user/login', to: 'users#login'
  put 'user/update/:id', to: 'users#update'
  delete 'user/delete/:id', to: 'users#destroy'

  post 'post/create', to: 'posts#create'
  get 'post/:id', to: 'posts#show'
  get 'posts/:username', to: 'posts#index'
  put 'post/update/:id', to: 'posts#update'
  delete 'post/delete/:id', to: 'posts#destroy'

  get 'comments/:post_id', to: 'comments#index'
  post 'comment/create', to: 'comments#create'
  delete 'comment/delete/:id', to: 'comments#destroy'
  get 'comment/:id', to: 'comments#show'
  put 'comment/update/:id', to: 'comments#update'
end
