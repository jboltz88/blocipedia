Rails.application.routes.draw do
  resources :wikis

  devise_for :users

  resources :users, only: [:show]

  authenticated do
    root to: 'wikis#index', as: :authenticated_root
  end

  get 'welcome/show'

  root to: 'welcome#show'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
