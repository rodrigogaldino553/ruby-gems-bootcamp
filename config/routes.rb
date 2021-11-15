Rails.application.routes.draw do
  devise_for :users
  resources :enrollments

  resources :courses do
    resources :lessons
    resources :enrollments, only: [:new, :create]
  end
  
  resources :users, only: [:index, :edit, :show, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root "home#index"
  get "home/activity"
end
