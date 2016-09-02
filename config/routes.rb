Rails.application.routes.draw do
  resources :wikis

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  devise_for :users

  authenticated do
    root to: 'wikis#index', as: :authenticated_root
  end

  get 'welcome/show'

  root to: 'welcome#show'
end
