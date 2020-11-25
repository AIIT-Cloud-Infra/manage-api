Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [] do
    collection do
      post :signup
      post :signin
    end
  end

  resources :instances, only: [:index, :create, :destroy] do
    member do
      post :start
      post :stop
      get :ssh_key
    end
  end

  resources :base_imgs, only: [:index]
end
