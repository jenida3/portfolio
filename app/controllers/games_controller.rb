class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @post = Post.new(game: @game)  # 新しい投稿用のインスタンスを作成
    @posts = @game.posts.order(created_at: :desc)  # 投稿を作成日時の降順で取得

    # OGPやTwitterカード用のタイトルと説明を設定
    content_for :title, @game.title
    content_for :description, @game.description || "掲示板: #{@game.title} - TactiZone"
  end
end
