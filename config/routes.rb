Rails.application.routes.draw do

  namespace :v1 do
    resources :applications do
      resources :chats ,only: [:show, :create, :index, :destroy] do
        get :search
        resources :messages ,only: [:create] 
      end
    end
  
  end

  match '*path', :to => 'application#routing_error', via: :any
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
