class OauthsController < ApplicationController
    skip_before_action :require_login, raise: false

    def oauth
      login_at(params[:provider])
    end

    def callback
      provider = params[:provider]
      if @user = login_from(provider)
        redirect_to root_path, notice: "ログインしました。"
      else
        begin
          @user = create_from(provider)
          reset_session # セッション固定攻撃対策
          auto_login(@user)
          redirect_to root_path, notice: "ログインしました。"
        rescue StandardError
          redirect_to root_path, alert: "ログインに失敗しました。"
        end
      end
    end
end
