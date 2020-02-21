Rails.application.routes.draw do
  get 'sessions/new'
  get 'home_page/home'
  resources :participate_ins
  resources :histories
  resources :favorites
  resources :challenges
  resources :users

  root 'home_page#home' 
  get '/signup', to: 'users#new'
  get '/new_challenge', to: 'challenges#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
