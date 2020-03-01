Rails.application.routes.draw do
  resource :registration, controller: 'rails_jwt_auth/registrations', only: [:create]
  resource :session, controller: 'rails_jwt_auth/sessions', only: %i[create destroy]
end
