class MicropostsController < ApplicationController

  before_action :logged_in_user, only:[:create, :destroy, :show, :search]
  before_action :correct_user, only: :destroy

  def create
    @post = current_user.microposts.build(micropost_params)
    @condition = current_user.conditions.build(condition_params[:condition])
    if @post.content.present?
      if @condition.level.present?
        @condition.memo = @post.content
        if @post.save
          @condition.date = @post.created_at
          @condition.save
          flash[:success] = "体調とツイートを送信しました!"
          redirect_to root_url
        else
          @feed_items = []
          flash[:danger] = "ツイートの文字数は140文字以内です"
          redirect_to request.referrer || root_url
        end
      else
        @feed_items = []
        flash[:danger] = "体調を選択してください"
        redirect_to request.referrer || root_url
      end
    else
      @feed_items = []
      flash[:danger] = "ツイートを入力してください"
      redirect_to request.referrer || root_url
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "ツイートを削除しました"
    redirect_to request.referrer || root_url
  end

  def show
    @micropost = Micropost.find(params[:id])
    @comments = @micropost.comments.includes(:user)
    @comment = Comment.new
  end

  def search
    @microposts = Micropost.paginate(page: params[:page]).search(params[:search])
    if @microposts.blank?
      flash.now[:danger] = "一致するツイートが見つかりませんでした"
    end
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

    def condition_params
      params.require(:micropost).permit(condition:[:level, :date, :memo])
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

end
