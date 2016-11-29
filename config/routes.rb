Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, except: [:new, :edit]
      resources :customers, except: [:new, :edit]
      resources :transactions, except: [:new, :edit]
      resources :invoices, except: [:new, :edit] do
        get '/customer', to: 'invoices/customers#show'
        get '/merchant', to: 'invoices/merchants#show'
      end
      resources :invoice_items, except: [:new, :edit] do
        get '/invoice', to: 'invoice_items/invoices#show'
        get '/item', to: 'invoice_items/items#show'
      end
      resources :items, except: [:new, :edit] do
        get '/invoice_items', to: 'items/invoice_items#index'
        get '/merchant', to: 'items/merchants#show'
      end
    end
  end
end
