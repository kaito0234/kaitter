class EventsController < ApplicationController
  before_action :logged_in_user
  before_action :set_event, only: [:show, :edit, :update, :destroy] #パラメータのidからレコードを特定するメソッド
  before_action :correct_user, only: [:create, :new, :edit, :update, :destroy]
  before_action :index_user, only: :index
  before_action :show_user, only: :show

  def index
    @user = User.find(params[:user_id])
    @events = Event.where(user_id: params[:user_id])

    gon.params_user_id = @user.id

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @events }
      format.json { render :json => @events }
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def users_event
    @events = Event.where(user_id: current_user.id).order(:allDay, :start)
    @user_events = Event.where(user_id: current_user.follower_ids).order(:user_id, :allDay, :start).includes(:user).group_by(&:user_id)
  end

  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to edit_user_event_path(current_user,@event), notice: '予定を作成しました' }
        format.json { render :index, status: :created, location: @event }
      else
        format.html { render :new, notice: 'タイトルを入力して下さい' }

        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to user_event_path(current_user,@event), notice: '予定を更新しました' }
        format.json { render :index, status: :ok, location: @event }
      else
        format.html { render :edit, notice: 'タイトルを入力して下さい' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    flash[:danger] = "予定を削除しました"
    redirect_to user_events_path(current_user)
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :memo, :place,
        :start, :end, :color, :allDay, :textColor).merge(user_id: current_user.id)
    end

    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def index_user
      @user = User.find(params[:user_id])
      if @user != current_user
        if @user.active_relationships.find_by(followed_id: current_user.id)
        else
          flash[:danger]="アクセスできません"
          redirect_to(root_url)
        end
      end
    end

    def show_user
      @event = Event.find(params[:id])
      if @event.user != current_user
        if @event.user.active_relationships.find_by(followed_id: current_user.id)
        else
          flash[:danger]="アクセスできません"
          redirect_to(root_url)
        end
      end
    end

end
