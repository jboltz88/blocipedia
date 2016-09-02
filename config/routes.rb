Rails.application.routes.draw do
  devise_for :users
  get 'welcome/show'

  root to: 'welcome#show'
end
