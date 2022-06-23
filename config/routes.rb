Rails.application.routes.draw do
  scope '/:locale' do
    resources :sessions, only: %i[new create destroy]
    resources :registrations, only: %i[new create]
    resources :imports, only: %i[new index create] do
      resources :error_logs, only: %i[index]
    end
    resources :contacts, only: %i[index]
  end
  root 'sessions#new'
end
