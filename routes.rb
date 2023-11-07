Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'breweries#index'

  controller :registrations do
    get :signup
    post 'signup' => :create_user
    get :login
    post 'login' => :login_user
    delete :logout
  end

  resources :breweries, only: %i[index show] do
    post :add_review, on: :collection
  end
end
