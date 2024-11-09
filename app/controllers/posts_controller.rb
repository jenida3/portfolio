class PostsController < ApplicationController
  before_action :require_login, only: [:create, :edit, :update, :destroy]
  before_action :set_game, only: [:create, :edit, :update, :destroy]
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def create
    @post = @game.posts.build(post_params)
    @post.user = current_user

    if @post.save
      flash[:success] = "投稿されました！"
      redirect_to game_path(@game)
    else
      redirect_to game_path(@game)  # 保存失敗時もリダイレクト
    end
  end

  def edit
    # @post は before_action でセット済み
  end

  def update
    if @post.update(post_params)
      flash[:success] = "投稿を更新しました！"
      redirect_to game_path(@game)
    else
      redirect_to game_path(@game)  # 更新失敗時もリダイレクト
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "投稿を削除しました！"
    redirect_to game_path(@game)
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def require_login
    unless current_user
      session[:return_to] = game_path(params[:game_id])
      flash[:danger] = "ログインが必要です"
      redirect_to login_path
    end
  end

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_post
    @post = @game.posts.find(params[:id])
  end

  def authorize_user
    unless @post.user == current_user
      flash[:danger] = "編集または削除する権限がありません"
      redirect_to game_path(@game)
    end
  end
end

