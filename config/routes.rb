Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :invoices do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end
      resources :merchants, except: [:new, :edit] do
        scope module: 'merchants' do
          get 'items', to: 'items#index'
          get 'invoices', to: 'invoices#index'
        end
      end
      resources :customers, except: [:new, :edit] do
        scope module: 'customers' do
          get '/invoices', to: 'invoices#index'
          get '/transactions', to: 'transactions#index'
        end
      end
      resources :transactions, except: [:new, :edit] do
        scope module: 'transactions' do
          get '/invoice', to: 'invoices#show'
        end
      end
      resources :invoices, except: [:new, :edit] do
        scope module: 'invoices' do
          get '/transactions', to: 'transactions#index'
          get '/invoice_items', to: 'invoice_items#index'
          get '/items', to: 'items#index'
          get '/customer', to: 'customers#show'
          get '/merchant', to: 'merchants#show'
        end
      end
      resources :invoice_items, except: [:new, :edit] do
        scope module: 'invoice_items' do
          get '/invoice', to: 'invoices#show'
          get '/item', to: 'items#show'
        end
      end
      resources :items, except: [:new, :edit] do
        scope module: 'items' do
          get '/invoice_items', to: 'invoice_items#index'
          get '/merchant', to: 'merchants#show'
        end
      end
    end
  end
end
