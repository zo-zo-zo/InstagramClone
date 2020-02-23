Rails.application.routes.draw do
  root 'sessions#new'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :favorites, only: [:create, :destroy, :show]
  # mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :blogs do
    collection do
      post :confirm
    end
  end
end
