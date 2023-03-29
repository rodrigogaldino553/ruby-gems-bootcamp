Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, :controllers => { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }


  resources :enrollments do
    get :my_students, on: :collection
    member do
      get :certificate
    end
  end

  resources :tags, only: [:create, :index, :destroy]
  resources :courses, except: [:edit] do
    get :purchased, :pending_review, :created, :unapproved, on: :collection
    member do
      get :analytics
      patch :approve
      patch :unapprove
    end
    resources :lessons, except: [:index] do
      resources :comments, except: [:index]
      put :sort
      member do
        delete :delete_video
      end
    end
    resources :enrollments, only: [:new, :create]
    resources :course_wizard, controller: 'courses/course_wizard'
  end

  
  
  resources :youtube, only: :show

  resources :users, only: [:index, :edit, :show, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "activity", to: 'home#activity'
  get "analytics", to: 'home#analytics'
  get "privacy_policy", to: 'home#privacy_policy'
  #get "charts/users_per_day", to: 'charts#users_per_day'
  #get "charts/enrollments_per_day", to: 'charts#enrollments_per_day'
  #get "charts/course_popularity", to: 'charts#course_popularity'
  #get "charts/money_makers", to: 'charts#money_makers'
  
  namespace :charts do
    get "users_per_day"
    get "enrollments_per_day"
    get "course_popularity"
    get "money_makers"
  end
  root "home#index"
end
