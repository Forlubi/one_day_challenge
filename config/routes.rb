Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth',
                                    confirmations: 'users/confirmations',
                                    registrations: 'users/registrations' }
  # get 'sessions/new'
  # get 'pages/home'
  resources :users
  resources :participate_ins
  resources :histories
  resources :favorites
  resources :challenges

  root                         'pages#home' 
  get    '/about',         to: 'pages#about'
  # get    '/signup',        to: 'users#new'
  get    '/new_challenge', to: 'challenges#new'
  # get    '/login',         to: 'sessions#new'
  # post   '/login',         to: 'sessions#create'
  # delete '/logout',        to: 'sessions#destroy'
  delete "users/:id", to: "users#destroy"
  
  get    '/search',        to: 'pages#search'
  get    '/search_result', to: 'pages#result'
 
  post '/participate/:challenge_id', to: 'users#participate'
  delete '/drop/:challenge_id', to: 'users#drop'
  get '/test/:id', to: 'users#test'

  post '/favorite/:challenge_id', to: 'users#favorite'
  delete '/unfavorite/:challenge_id', to: 'users#unfavorite'

  get '/filter/:filter', to: 'challenges#filter'
end
