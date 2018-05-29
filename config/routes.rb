Rails.application.routes.draw do
  get 'sessions/new'
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :posts
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy, :index]
#  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  if Rails.env.production?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
