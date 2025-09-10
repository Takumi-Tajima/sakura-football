Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_for :administrators, controllers: { sessions: 'administrators/sessions' }

  namespace :administrators do
    root 'lessons#index'
    resources :lessons, only: %i[index show new edit create update destroy]
    resources :users, only: %i[index show edit update destroy]
  end

  namespace :users do
    # MEMO: これネストさせてるから、予約しているレッスン一覧やるときは、新しくリソース切ってあげる必要があるね。どっちの方がいいんだろうか？
    resources :lessons, only: [] do
      resources :bookings, only: %i[index show new create destroy], module: :lessons
    end
  end

  resources :lessons, only: %i[index show]

  root 'lessons#index'

  get 'up' => 'rails/health#show', as: :rails_health_check
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
