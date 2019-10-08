Rails.application.routes.draw do
  
  resources :matches

  get "/players", to: "players#index", as: :all_players
  get "/players/:username", to: "players#show", as: :get_player
  
  devise_for :users, :controllers => {:registrations => "registrations", :omniauth_callbacks => "callbacks"}
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end
  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
  end

  scope '/api' do
    post '/ping/:game/matches', to: 'api#pingMatch'
  end

  root to: "home#index"

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
