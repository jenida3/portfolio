Rails.application.routes.draw do
  # パスワードリセット関連
  resources :password_resets, only: [ :new, :create, :edit, :update ]

  # ゲームと投稿関連
  resources :games, only: [ :index, :show ] do
    resources :posts, only: [ :create, :edit, :update, :destroy ] do
      member do
        post :toggle_like, to: "likes#toggle"
      end
    end
  end

  # ダッシュボード
  get "dashboard", to: "dashboard#index", as: "dashboard"
  get "dashboard/search", to: "dashboard#search", as: "dashboard_search"

  # セッション管理
  resources :sessions, only: [ :new, :create, :destroy ]

  # ユーザー登録
  resources :users, only: [ :new, :create, :show ]  # showアクションを追加

  # タスク管理
  resources :tasks

  # ヘルスチェック
  get "up", to: "rails/health#show", as: :rails_health_check

  # PWA関連
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest", to: "rails/pwa#manifest", as: :pwa_manifest

  # 認証関連
  get "signup", to: "users#new", as: "signup"
  post "signup", to: "users#create"
  get "login", to: "sessions#new", as: "login"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy", as: "logout"

  # Google認証
  get "/oauth/:provider", to: "oauths#oauth", as: :auth_at_provider
  get "/oauth/callback", to: "oauths#callback"
  post "/oauth/callback", to: "oauths#callback"

  # トップページ
  root "dashboard#index"

  # 開発環境でのみLetter Openerを有効化
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
