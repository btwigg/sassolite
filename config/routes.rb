Config::Application.routes.draw do
  
  namespace :admin do
    resources :clients do
      resources :addresses
    end
    resources :projects do
      resources :project_durations
      resource :status_update do
        member do
          post :unlock
        end
      end
    end
    resources :users
  end
  
  resources :password_resets
  
  resources :reports
  
  resources :user_sessions do
    delete :destroy, :on => :collection
  end
  
  match 'login' => "user_sessions#new"
  match 'logout' => "user_sessions#destroy"

  root :to => "home#index"
end