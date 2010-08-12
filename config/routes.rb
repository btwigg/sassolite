Config::Application.routes.draw do
  
  namespace :admin do
    resources :clients
    resources :users
  end
  
  resources :password_resets
  
  resources :user_sessions do
    delete :destroy, :on => :collection
  end
  
  match 'login' => "user_sessions#new"
  match 'logout' => "user_sessions#destroy"

  root :to => "home#index"
end