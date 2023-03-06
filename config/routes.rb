Rails.application.routes.draw do
  # 管理者
  devise_for :admin, skip: [:registraions, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # 会員
  devise_for :members, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about"
    resources :members, only: [:show, :edit, :update]
    resources :posts do
      resource :post_reports, only: [:new, :create] do
        get :done, on: :collection
      end
      resource :favorites, only: [:create, :destroy]
      resource :interests, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy] do
        resources :comment_reports, only: [:new, :create] do
          get :done, on: :collection
        end
      end
    end
    resource :notifications, only: [:index]
  end

  namespace :admin do
    root to: "homes#top"
    resources :posts, only: [:show, :index, :destroy]
    resources :categories, only: [:create, :index, :destroy]
    resources :tag, only: [:create, :index, :destroy]
    resources :members, only: [:index, :show, :update]
  end

  get "search" => "searches#search"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
