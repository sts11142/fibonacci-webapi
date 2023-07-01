Rails.application.routes.draw do
  get 'easy_api', to: 'easy_api#index'
  get 'fb', to: 'fb#index'

  root 'application#hello'
end
