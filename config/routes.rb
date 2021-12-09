Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  
  get 'signup' => 'users#new'
  
  resources :users, except: [:destroy]
  
  resources :blogs, except: [:new] do
    resources :blog_comments, only: [:create, :destroy]
  end
end