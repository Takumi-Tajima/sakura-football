Rails.application.routes.draw do
  devise_for :administrators
  get 'up' => 'rails/health#show', as: :rails_health_check
end
