class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  before_action :correct_user
  

  def index
    @meetings = Meeting.where(user_id: params[:user_id])
  end

  def index_week
    @meetings = Meeting.where(user_id: params[:user_id])
  end

  def show
    @meeting = Meeting.find(params[:id])
  end

  def new
    @meeting = Meeting.new
  end

  def edit
    @user = User.find(params[:user_id])
    @meeting = Meeting.find(params[:id])
  end

  def create
    @meeting = Meeting.new(meeting_params)
    if @meeting.save
      redirect_to user_meeting_path(current_user, @meeting)
      flash[:success] = "予定を作成しました!"
    else
      flash.now[:danger] = "入力項目が足りません!"
      render 'new'
    end    
  end

  def update
    @meeting = Meeting.find(params[:id])
    if @meeting.update_attributes(meeting_params)
      redirect_to user_meeting_path(current_user, @meeting)
      flash[:success] = "予定を更新しました!"
    else
      flash.now[:danger] = "入力項目が足りません!"
      render 'edit'
    end
  end

  def destroy
    @meeting.destroy
    flash[:success] = "予定を削除しました"
    redirect_to request.referrer || root_url
  end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_meeting
        @meeting = Meeting.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def meeting_params
        params.require(:meeting).permit(:name, :start_time, :memo, :place).merge(user_id: current_user.id)
      end

      def correct_user
        user = User.find(params[:user_id])
        redirect_to(root_url) unless current_user?(user)
      end
end
