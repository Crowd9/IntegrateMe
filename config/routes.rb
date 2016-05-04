Rails.application.routes.draw do
  resources :campaigns do
    resources :entries, only: [:edit, :update, :create, :new]
  end
  devise_for :users
  resources :entries
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'campaigns#index'
  get ':competition_id/:permalink/:campaign_id' => 'competitions#entrant_page', constraints: {competition_id: /\d+/}, as: :enterant
  post 'entries' => 'entries#create'

end
