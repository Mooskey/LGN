Rails.application.routes.draw do


  post 'events/:id/hosts' => 'events#toggle_host'

  # get 'games/show'
  get 'games' => 'games#show'

  delete 'users/:id/:game_id' => 'users#remove_game'

  post 'add_game' => 'games#add_to_user'#, as: "add_game"
  # post 'game_added' => 'games#add_to_user', as: "game_added"

  resources :events

  post 'events/:id' => 'events#going'

  root 'home#home'
  devise_for :users, :controllers => { :sessions => "custom_sessions" }
  resources :users
  get 'locations/new' => 'locations#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'users/:id' => 'users#show'
  get 'users/index'
  get 'users/:id/edit' => 'users#edit'

  # messaging
  get 'rooms/show'
  get 'chat' => 'rooms#show'


  # TODO: route  chat by id like below
  # get '/rooms/:id' => 'rooms#show'
  mount ActionCable.server => '/cable'
end
