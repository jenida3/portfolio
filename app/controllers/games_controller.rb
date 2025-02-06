# app/controllers/games_controller.rb
class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @post = Post.new(game: @game)
    @posts = @game.posts.order(created_at: :desc)

    # ページ固有のタイトルと説明をインスタンス変数に設定
    @page_title = @game.title
    @page_description = @game.description || "掲示板: #{@game.title} - TactiZone"
  end
end
