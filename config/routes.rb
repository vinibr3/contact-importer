Rails.application.routes.draw do
  scope '/:locale' do
    resources :sessions, only: %i[new create destroy]
    resources :imports, only: %i[new]
  end
  root 'sessions#new'
end
