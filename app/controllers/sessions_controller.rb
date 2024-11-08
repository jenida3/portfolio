class SessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:email], params[:password])
    if user
      redirect_to dashboard_path, success: "ログインしました"
    else
      flash.now[:danger] = "ログインに失敗しました" # フラッシュメッセージを設定
      render :new, status: :unprocessable_entity # HTTPステータスコード422を返す
    end
  end

  def destroy
    logout
    redirect_to root_path, success: "ログアウトしました"
  end
end
