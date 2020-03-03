Rails.application.routes.draw do
  resource :registration, defaults: { format: :json }, controller: 'rails_jwt_auth/registrations', only: [:create]
  resource :session, defaults: { format: :json }, controller: 'rails_jwt_auth/sessions', only: %i[create destroy]

  resources :users, defaults: { format: :json }, only: :index do
    scope module: :users do
      resources :news_items, only: [:index]
    end
  end

  resources :news_items, defaults: { format: :json } do
    collection do
      get :unread
    end

    member do
      post :add_to_favorites
    end
  end
end
