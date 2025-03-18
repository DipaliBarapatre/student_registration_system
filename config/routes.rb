Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {
   registrations: "users/registrations", 
  }

  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "devise/sessions#new"
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :students, only: [:index, :show, :edit, :update] do
      collection do
        post :import
      end
  end
  patch 'verify_student/:id', to: 'students#verify', as: "verify_student"
end
