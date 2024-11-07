Rails.application.routes.draw do
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
  get "signup", to: "users#new", as: "signup"        # 新規登録ページ
  post "signup", to: "users#create"                  # 新規登録アクション
  get "login", to: "sessions#new", as: "login"       # ログインページ
  post "login", to: "sessions#create"                # ログインアクション
  delete "logout", to: "sessions#destroy", as: "logout" # ログアウトアクション

  # トップページをログインページに設定
  root "sessions#new"
end
