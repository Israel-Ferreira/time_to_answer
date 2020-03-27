# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins
  devise_for :profiles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/welcome/index'
  get '/inicio', to: 'welcome#index'

  root to: 'welcome#index'
end
