class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザー登録が完了しました。"  # 成功メッセージを追加
      redirect_to root_path
    else
      puts @user.errors.full_messages # デバッグ用
      flash.now[:danger] = "登録に失敗しました。"  # 失敗メッセージを追加
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
  end
end
