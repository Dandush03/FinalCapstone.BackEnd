# frozen_string_literal: true

Rails.application.routes.draw do
  get '/api', to: 'api#index'

  namespace :api, defaults: { format: :json } do
    resources :tasks, except: %i[destroy show]
    get '/searcher', to: 'tasks#searcher'
    get '/searcher/by_category_date', to: 'tasks#search_by_category'

    namespace :auth do
      get '/', to: 'authentication#authorize'
      post '/login', to: 'authentication#authenticate'
      post '/signup', to: 'authentication#create'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
