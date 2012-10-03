Irails::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users

  match '/stripe_listener' => 'subscription_events#stripe', method: :post

  resource :subscription, only: [:edit, :update] do
    get :card_details
  end


  root to: 'pages#show', id: 'home'
end
