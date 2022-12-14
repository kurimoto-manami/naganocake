Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: "homes#top"
    get '/home/about' => 'homes#about',as:'about'
    resources :customers, only: [:show, :edit, :update,]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :update, :destroy]
    resources :orders, only: [:new, :create, :index, :show]
    resources :addresses, only: [:create, :index, :edit, :update, :destroy]
    get '/customers/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch '/customers/:id/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all'
    post '/orders/confirm' => 'orders#confirm', as: 'confirm'
    get '/orders/completion' => 'orders#completion', as: 'completion'
  end

  namespace :admin do
    root to: "homes#top"
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_details, only: [:update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
