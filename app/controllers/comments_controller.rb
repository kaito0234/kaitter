class CommentsController < ApplicationController
  before_action :logged_in_user, only:[:create, :destroy]
  # before_action :correct_user, only: :destroy

  def create
    @comment =  Comment.new(comment_params)
    if @comment.save
      @comment.micropost.create_notice_comment(current_user, @comment.id)
      flash[:success] = "コメントを送信しました!"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "送信に失敗!"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    comment =  Comment.find_by(id: params[:id])
    comment.destroy
    flash[:success] = "コメントを削除しました"
    redirect_to request.referrer || root_url
  end

    private

      def comment_params
        params.require(:comment).permit(:text).merge(micropost_id: params[:micropost_id], user_id: current_user.id)
      end

end
