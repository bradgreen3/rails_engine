Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, except: [:new, :edit] do
        get '/items', to: 'merchants/items#index'
        get '/invoices', to: 'merchants/invoices#index'
      end
      resources :customers, except: [:new, :edit] do
        get '/invoices', to: 'customers/invoices#index'
        get '/transactions', to: 'customers/transactions#index'
        end
      resources :transactions, except: [:new, :edit] do
        get '/invoice', to: 'transactions/invoices#show'
      end
      resources :invoices, except: [:new, :edit] do
        get '/transactions', to: 'invoices/transactions#index'
        get '/invoice_items', to: 'invoices/invoice_items#index'
        get '/items', to: 'invoices/items#index'
      end
      resources :items, except: [:new, :edit]
      resources :invoice_items, except: [:new, :edit]
    end
  end
end
