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
          get '/favorite_merchant', to: 'customers#favorite_merchant'
        end
      end
      resources :merchants,     only: [:index, :show] do
        collection do
          get '/find',         to: 'merchants#find'
          get '/find_all',     to: 'merchants#find_all'
          get '/random',       to: 'merchants#random'
          get '/most_revenue', to: 'merchants#most_revenue'
          get '/most_items',   to: 'merchants#most_items'
        end

        member do
          get :items
          get :invoices
          get '/revenue',                         to: 'merchants#revenue'
          get '/favorite_customer',               to: 'merchants#favorite_customer'
          get '/customers_with_pending_invoices', to: 'merchants#customers_with_pending_invoices'
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
