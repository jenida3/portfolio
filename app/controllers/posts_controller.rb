class PostsController < ApplicationController
  before_action :require_login, only: [ :create ]  # 投稿作成アクションにログインチェックを追加

  def create
    @game = Game.find(params[:game_id])  # ゲームを取得
    @post = @game.posts.build(post_params)  # ゲームに関連付けて新しい投稿を作成
    @post.user = current_user  # ログインしているユーザーを投稿に関連付ける

    if @post.save
      flash[:success] = "投稿が成功しました！"
      redirect_to game_path(@game)  # 投稿が成功したら、ゲーム詳細ページにリダイレクト
    else
      render "games/show"  # 投稿が保存できなかった場合、ゲーム詳細ページを再表示
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)  # 必要なパラメータを許可
  end

  def require_login
    unless current_user
      session[:return_to] = game_path(params[:game_id])  # ゲーム詳細ページのURLをセッションに保存
      flash[:danger] = "ログインが必要です"
      redirect_to login_path  # ログインページにリダイレクト
    end
  end
end
