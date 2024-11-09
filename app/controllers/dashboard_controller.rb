class DashboardController < ApplicationController
  def index
    # ゲームタイトルを全て取得
    @games = Game.all
  end
end
