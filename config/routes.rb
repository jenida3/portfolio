Rails.application.routes.draw do
  # ゲーム関連のルート
  resources :games, only: [ :index, :show ] do
    resources :posts, only: [ :create, :edit, :update, :destroy ] do
      # いいね機能のルートを追加
      member do
        post :toggle_like, to: "likes#toggle"
      end
    end
  end

  # ダッシュボードのルート
  get "dashboard", to: "dashboard#index", as: "dashboard"
  get "dashboard/search", to: "dashboard#search", as: "dashboard_search"

  # セッション関連のルート
  resources :sessions, only: [ :new, :create, :destroy ]

  # ユーザー関連のルート
  resources :users, only: [ :new, :create ]

  # タスク関連のルート
  resources :tasks

  # ヘルスチェック
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA用ルート
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # 認証関連ルート
  get "signup", to: "users#new", as: "signup"
  post "signup", to: "users#create"
  get "login", to: "sessions#new", as: "login"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy", as: "logout"

  # トップページをダッシュボードに設定
  root "dashboard#index"
end
