class EventsController < ApplicationController
  before_action :logged_in_user
  before_action :set_event, only: [:show, :edit, :update, :destroy] #パラメータのidからレコードを特定するメソッド
  before_action :correct_user, only: [:create, :new, :edit, :update, :destroy]
  before_action :index_user, only: :index
  before_action :show_user, only: :show

  def index
    @user = User.find(current_user.id)
    @events = Event.where(user_id: params[:user_id])
    
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.xml { render :xml => {:events => @events, :user => @user }}
  #     format.json { render :json => {:events => @events, :user => @user }}
  #   end
  # end

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

  def create
    @event = Event.new(event_params)
    # if @event.save
    #   flash[:success] = "予定を作成しました!"
    #   redirect_to @event
    # else
    #   flash.now[:danger] = "入力項目が足りません!"
    #   render 'new'
    # end

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
    # if @event.update_attributes(event_params)
    #   flash[:success] = "予定を更新しました!"
    #   redirect_to @event
    # else
    #   flash.now[:danger] = "入力項目が足りません!"
    #   render 'index'
    # end
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
    # respond_to do |format|
    #   format.html { redirect_to user_events_path(current_user), notice: '予定を削除しました' }
    #   format.json { head :no_content }
    # end
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
