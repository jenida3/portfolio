class SessionsController < ApplicationController
  def new
    # ログインページの表示
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      flash[:success] = "ログインしました！"  # 成功時のフラッシュメッセージ
      redirect_to(session.delete(:return_to) || root_path) # 元のページにリダイレクト、またはトップページ
    else
      flash.now[:danger] = "ログインに失敗しました。メールアドレスまたはパスワードが間違っています。"  # 失敗時のフラッシュメッセージ
      render :new, status: :unprocessable_entity # 再度ログイン画面を表示（HTTPステータス422を設定）
    end
  end

  def destroy
    logout
    flash[:success] = "ログアウトしました" # ログアウト成功時のフラッシュメッセージ
    redirect_to root_path
  end
end
