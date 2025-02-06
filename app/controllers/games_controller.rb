class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @post = Post.new(game: @game)
    @posts = @game.posts.order(created_at: :desc)

    # ゲーム掲示板ページのタイトルと説明を設定
    @page_title = @game.title
    @page_description = "#{@game.title}の掲示板 - TactiZone"
  end
end

