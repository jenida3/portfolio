class DashboardController < ApplicationController
  def index
    @games = Game.all
  end

  def search
    if params[:game_id].blank?
      flash[:danger] = "ゲームを選択してください。" # フラッシュメッセージ
      redirect_to dashboard_path
      return
    end

    @games = Game.all
    @selected_game = Game.find_by(id: params[:game_id])

    if @selected_game
      if params[:keyword].present?
        @posts = @selected_game.posts.where("content LIKE ?", "%#{params[:keyword]}%").order(created_at: :desc)

      else
        flash[:danger] = "キーワードを入力してください。" # キーワード未入力時のメッセージ
        redirect_to dashboard_path
      end
    else
      @posts = []
      flash.now[:danger] = "選択したゲームが見つかりませんでした。" # 選択されたゲームが見つからない場合のメッセージ
    end
  end
end
