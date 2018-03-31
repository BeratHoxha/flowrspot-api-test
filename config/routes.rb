# frozen_string_literal: true

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

      resources :sightings, except: %i[edit new] do
        resources :images, only: %i[index create destroy],
                           controller: 'sightings/images'
        resources :likes, only: %i[index create destroy], controller: 'sightings/likes'
        resources :comments, only: %i[index create destroy], controller: 'sightings/comments'
      end


      resources :flowers, only: [:index, :show] do
        collection do
          get :search, to: 'flowers#search'
        end
        resources :sightings, only: [:index], controller: 'flowers/sightings'
        resources :images, only: [:index]
      end

    end
  end

  root 'welcome#index'
end
