Rails.application.routes.draw do
  get 'easy_api', to: 'easy_api#index'
  root 'application#hello'
end
