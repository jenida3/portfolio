require "active_support/core_ext/integer/time"

Rails.application.configure do
  # 基本設定
  config.enable_reloading = false
  config.eager_load = true

  # エラーレポート設定
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # 静的ファイルの配信
  config.assets.compile = false
  config.active_storage.service = :local

  # SSL設定
  config.force_ssl = true

  # ログ設定
  config.logger = ActiveSupport::Logger.new(STDOUT).tap { |logger| logger.formatter = ::Logger::Formatter.new }
  config.log_tags = [:request_id]
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # キャッシュ設定（任意）
  # config.cache_store = :mem_cache_store

  # メール設定
  config.action_mailer.perform_caching = false

  # I18n設定
  config.i18n.fallbacks = true

  # デプリケーションログ無効化
  config.active_support.report_deprecations = false

  # マイグレーション後のスキーマダンプ無効化
  config.active_record.dump_schema_after_migration = false

  # ホスト設定（独自ドメインを追加）
  config.hosts << "tactizone.jp"
end