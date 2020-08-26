class UsersController < ApplicationController
  before_action :logged_in_user, only:[:index, :edit, :update, :destroy,
                                               :following, :followers, :show, :show_event]
  before_action :correct_user,   only:[:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.order("created_at DESC").paginate(page:params[:page])
  end

  def show
    @user = User.find(params[:id])
    @following
    @microposts = @user.microposts.paginate(page: params[:page])
    @like_microposts = @user.like_microposts.paginate(page: params[:page])
    @comment_microposts = @user.comment_microposts.paginate(page: params[:page])
    @events = Event.where(user_id: @user.id)
    @event = Event.new
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ようこそ”Kaitter japan”へ!"
      redirect_to @user
    else
        render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.id == 111
      flash[:danger] = "ゲストアカウントのユーザー情報は変更できません"
      redirect_to root_url
    else
      @user = User.find(params[:id])
      if @user.update_attributes(user_params)
        flash[:success]="ユーザー情報を変更しました"
        redirect_to @user
      else
        render 'new'
      end
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to users_url
  end

  def following
    @title = "フォロー"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :icon)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
