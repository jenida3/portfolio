Rails.application.config.sorcery.submodules = [:external, :reset_password]

Rails.application.config.sorcery.configure do |config|
  # External authentication with Google
  config.external_providers = [:google]
  config.google.key = Rails.application.credentials.dig(:google, :client_id)
  config.google.secret = Rails.application.credentials.dig(:google, :client_secret)
  config.google.callback_url = "http://localhost:3000/oauth/callback?provider=google"
  config.google.user_info_mapping = { email: "email", username: "name" }
  config.google.scope = "https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile"

  # Additional config for user authentication
  config.user_config do |user|
    user.stretches = 1 if Rails.env.test?
    user.reset_password_mailer = UserMailer # Reset password mailer設定
  end

  # Set the User model class
  config.user_class = "User"
end
