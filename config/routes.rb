Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, except: [:new, :edit]
      resources :customers, except: [:new, :edit]
      resources :transactions, except: [:new, :edit]
      resources :invoices, except: [:new, :edit]
      resources :invoice_items, except: [:new, :edit]
      resources :items, except: [:new, :edit] do
        get '/invoice_items', to: 'items/invoice_items#index'
        get '/merchant', to: 'items/merchants#show'
      end
    end
  end
end
