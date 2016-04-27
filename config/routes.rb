Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :contacts
  resources :integrations
  resources :entries
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  get ':competition_id/:permalink' => 'competitions#entrant_page', constraints: {competition_id: /\d+/}
  post 'entries' => 'entries#create'
end
