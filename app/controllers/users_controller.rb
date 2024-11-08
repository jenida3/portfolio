class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザー登録が完了しました"  # フラッシュメッセージを設定
      redirect_to root_path
    else
      flash.now[:danger] = "ユーザー登録に失敗しました"  # フラッシュメッセージを設定
      render :new, status: :unprocessable_entity  # HTTPステータスコード422を返す
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :nickname)
  end
end
