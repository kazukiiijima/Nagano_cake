Rails.application.routes.draw do


  devise_for :admin, controllers: {sessions: 'admin/sessions', registrations: 'admin/registrations'}
  root :to => 'homes#top'
  get "/about" => "homes#about"
  post "/orders/confirm" => "public/orders#confirm"
  get "/orders/complete" => "public/orders#complete"
  get "/costomers/confirm" =>  "public/customers#confirm"
  patch "/costomers/destroy" => "public/customers#destroy"
  delete "/cart_items/destroy_all"  => "public/cart_items#destroy_all"

  scope module: :public do
    resources :items, only: [:index, :show]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :orders, only: [:new, :index, :create, :show]
    resources :cart_items, only: [:index, :update, :create, :destroy]
    resource :customer, only: [:show, :edit, :update]
  end
  devise_for :customer, controllers: {sessions: 'public/sessions', registrations: 'public/registrations'}

  namespace :admin do
  	resources :items, only: [:index, :new, :create, :show, :edit, :update]
  	resources :genres, only: [:index, :create, :edit, :update]
  	resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
