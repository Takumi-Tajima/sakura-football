Rails.application.routes.draw do
  devise_for :administrators, controllers: { sessions: 'administrators/sessions' }
  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :administrators do
    root 'home#index'
  end
end
