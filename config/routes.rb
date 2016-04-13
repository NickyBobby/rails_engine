Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :customers,     only: [:index, :show] do
        collection do
          get '/find',     to: 'customers#find'
          get '/find_all', to: 'customers#find_all'
          get '/random',   to: 'customers#random'
        end

        member do
          get :invoices
          get :transactions
        end
      end
      resources :merchants,     only: [:index, :show] do
        collection do
          get '/find',     to: 'merchants#find'
          get '/find_all', to: 'merchants#find_all'
          get '/random',   to: 'merchants#random'
        end

        member do
          get :items
          get :invoices
        end
      end
      resources :items,         only: [:index, :show] do
        collection do
          get '/find',     to: 'items#find'
          get '/find_all', to: 'items#find_all'
          get '/random',   to: 'items#random'
        end

        member do
          get :invoice_items
          get :merchant
        end
      end
      resources :invoice_items, only: [:index, :show] do
        collection do
          get '/find',     to: 'invoice_items#find'
          get '/find_all', to: 'invoice_items#find_all'
          get '/random',   to: 'invoice_items#random'
        end

        member do
          get :invoice
          get :item
        end
      end
      resources :invoices,      only: [:index, :show] do
        collection do
          get '/find',     to: 'invoices#find'
          get '/find_all', to: 'invoices#find_all'
          get '/random',   to: 'invoices#random'
        end

        member do
          get :transactions
          get :invoice_items
          get :items
          get :customer
          get :merchant
        end
      end
      resources :transactions,  only: [:index, :show] do
        collection do
          get '/find',     to: 'transactions#find'
          get '/find_all', to: 'transactions#find_all'
          get '/random',   to: 'transactions#random'
        end

        member do
          get :invoice
        end
      end
    end
  end
end
