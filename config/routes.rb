# frozen_string_literal: true

Rails.application.routes.draw do

  
  devise_for :users

  namespace :users_backoffice do 
    get 'welcome/index'
  end

  namespace :site do
    get 'welcome/index'
  end


  namespace :admins_backoffice do
    get 'welcome/index'
    resources :admins
    resources :subjects
    resources :questions
  end

  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/inicio', to: 'site/welcome#index'

  root to: 'site/welcome#index'
end
