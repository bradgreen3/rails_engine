Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :invoices do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
      end
      namespace :merchants do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get 'most_revenue', to: 'revenues#index'
        get 'most_items', to: 'most_items#index'
        get 'revenue', to: 'revenues#index'
      end
      namespace :items do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get 'most_revenue', to: 'revenues#index'
      end
      namespace :transactions do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
      end
      namespace :invoice_items do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
      end
      namespace :customers do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
      end
      resources :merchants, except: [:new, :edit] do
        scope module: 'merchants' do
          get 'items', to: 'items#index'
          get 'invoices', to: 'invoices#index'
          get 'revenue', to: 'revenues#show'
          get 'favorite_customer', to: 'favorites#show'
        end
      end
      resources :customers, except: [:new, :edit] do
        scope module: 'customers' do
          get '/invoices', to: 'invoices#index'
          get '/transactions', to: 'transactions#index'
          get '/favorite_merchant', to: 'favorites#show'
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
