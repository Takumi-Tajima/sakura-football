Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_for :administrators, controllers: { sessions: 'administrators/sessions' }

  namespace :administrators do
    root 'lessons#index'
    resources :lessons, only: %i[index show new edit create update destroy]
    resources :users, only: %i[index show edit update destroy]
    resources :bookings, only: %i[index]
  end

  namespace :users do
    resources :bookings, only: %i[index show]
    resources :booking_histories, only: %i[index show]
    resources :user_lesson_attendance_rankings, only: %i[index]
    resources :lessons, only: [] do
      resources :bookings, only: %i[new create destroy], module: :lessons
    end
  end

  resources :lessons, only: %i[index show]

  root 'lessons#index'

  get 'up' => 'rails/health#show', as: :rails_health_check
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
