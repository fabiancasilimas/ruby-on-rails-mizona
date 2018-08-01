Rails.application.routes.draw do
  match '/contacts',	to: 'contacts#new',	via: 'get'	
  resources :contacts,	only: [:new, :create]
  #resources :contacts, except: [:new, :create]
  #resources :contacts
  #get 'contacts/new'
  #get 'contacts/create'
  resources :users
  get 'web/index'
  root :to => 'web#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
