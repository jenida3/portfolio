class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @post = Post.new(game: @game)
    @posts = @game.posts.order(created_at: :desc)
    
    # ページ固有のタイトルと説明をビューに渡す
    content_for :title, @game.title
    content_for :description, @game.description || "掲示板: #{@game.title} - TactiZone"
  end
end

