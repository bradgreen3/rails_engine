Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, except: [:new, :edit]
      resources :customers, except: [:new, :edit]
      resources :transactions, except: [:new, :edit]
    end
  end
end
