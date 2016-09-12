Rails.application.routes.draw do
  resources :wikis do
    resources :collaborators, only: [:create, :destroy]
  end

  devise_for :users

  resources :users, only: [:show]

  resources :charges, only: [:new, :create]

  patch "downgrade_account", to: "users#downgrade_account", as: "downgrade_account"

  authenticated do
    root to: 'wikis#index', as: :authenticated_root
  end

  get 'welcome/show'

  root to: 'welcome#show'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
