Rails.application.routes.draw do

  get 'sessions/new'
  resources :users, only: %i(new create show edit update)
  resources :posts do
    resources :comments
  end
  resources :sessions, only: %i(new create destroy)
  resources :favorites, only: %i(create destroy index)
#  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  if Rails.env.production?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
