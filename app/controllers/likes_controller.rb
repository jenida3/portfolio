class LikesController < ApplicationController
    before_action :require_login, only: [ :toggle ]
    before_action :set_post

    def toggle
      like = @post.likes.find_by(user: current_user)
      if like
        like.destroy
        @liked = false
      else
        @post.likes.create(user: current_user)
        @liked = true
      end

      respond_to do |format|
        format.html { redirect_to request.referrer || root_path }
        format.js # Ajax用のレスポンスを準備
      end
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    def require_login
      unless logged_in?
        flash[:danger] = "ログインしてください。"
        redirect_to request.referrer || root_path # 元の画面にリダイレクト
      end
    end
end
