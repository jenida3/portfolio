class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @post = Post.new(game: @game)  # 新しい投稿用のインスタンスを作成
  end
end
