Rails.application.routes.draw do
  devise_for :users
  resources :enrollments do
    get :my_students, on: :collection
  end

  resources :courses do
    get :purchased, :pending_review, :created, on: :collection
    resources :lessons
    resources :enrollments, only: [:new, :create]
  end
  
  resources :users, only: [:index, :edit, :show, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "activity", to: 'home#activity'
  get "analytics", to: 'home#analytics'

  root "home#index"
end
