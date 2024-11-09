class SessionsController < ApplicationController
  def new
    # ログインページ
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      flash[:success] = "ログインしました！"
      redirect_to(session.delete(:return_to) || root_path)  # 元のゲーム詳細ページに戻る、なければトップページ
    else
      flash.now[:danger] = "ログインに失敗しました"
      render :new
    end
  end

  def destroy
    logout
    flash[:success] = "ログアウトしました"
    redirect_to root_path
  end
end
