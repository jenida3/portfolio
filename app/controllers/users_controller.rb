class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザー登録が完了しました"
      redirect_to root_path
    else
      flash.now[:danger] = "ユーザー登録に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = current_user
    @posts = @user.posts.order(created_at: :desc)  # ユーザーの投稿を取得
    @liked_posts = @user.liked_posts.order('likes.created_at DESC')  # ユーザーがいいねした投稿を取得
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :nickname)
  end
end

