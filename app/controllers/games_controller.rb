class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @post = Post.new(game: @game) # 新しい投稿用のインスタンスを作成
    @posts = @game.posts.order(created_at: :desc) # 投稿を作成日時の降順で取得
  end
end