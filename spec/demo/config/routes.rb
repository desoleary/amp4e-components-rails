Rails.application.routes.draw do
  resources :components, only: :index

  root 'components#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
