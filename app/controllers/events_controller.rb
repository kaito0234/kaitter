class EventsController < ApplicationController
  before_action :logged_in_user
  before_action :set_event, only: [:show, :edit, :update, :destroy] #パラメータのidからレコードを特定するメソッド

  def index
    @events = Event.where(user_id: current_user.id)

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
    if @event.save
      flash.now[:success] = "予定を作成しました!"
      render 'index'
    else
      flash.now[:danger] = "入力項目が足りません!"
      render 'new'
    end  

    # respond_to do |format|
    #   if @event.save
    #     format.html { redirect_to :index, notice: 'Event was successfully created.' }
    #     format.json { render :index, status: :created, location: @event }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @event.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:success] = "予定を更新しました!"
      redirect_to events_path
    else
      flash.now[:danger] = "入力項目が足りません!"
      render 'index'
    end
    # respond_to do |format|
    #   if @event.update(event_params)
    #     format.html { redirect_to @event, notice: 'Event was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @event }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @event.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :memo, :place,
        :start, :end, :color, :allday).merge(user_id: current_user.id)
    end

end
