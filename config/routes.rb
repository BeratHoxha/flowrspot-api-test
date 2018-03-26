Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1 do
      resources :users do
        collection do
          post :login, to: 'sessions#create'
          post :register, to: 'registrations#create'
          get :me, to: 'users#me'
          get '/:id', to: 'users#show'
        end
        member do
          put :me, to: 'users#update'
          get :sightings, to: 'users/sightings#index'
        end
      end

      resources :sightings, except: [:edit, :new] do
        resources :images, only: [:index, :create, :destroy],
                           controller: 'sightings/images'
      end

      resources :flowers, only: [:index, :show] do
        collection do
          get :search, to: 'flowers#search'
        end
        resources :images, only: [:index]
      end

    end
  end

  root 'welcome#index'
end
