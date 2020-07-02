class CommentsController < ApplicationController
  # before_action :logged_in_user, only:[:create, :destroy]
  # before_action :correct_user, only: :destroy

  def create
    @comment =  Comment.new(comment_params)
    # @comment = Comment.new(text: comment_params[:text], micropost_id: comment_params[:micropost_id], user_id: current_user.id)
    if @comment.save
      flash[:success] = "コメントを送信しました!"
      redirect_back(fallback_location: root_path)
    else
      flash[:success] = "送信に失敗!"
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

      # def correct_user
      #   @comment = current_user.comments.find_by(id: params[:id])
      #   redirect_to root_url if @comment.nil?
      # end

end
