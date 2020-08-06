class ConditionsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:create, :new, :edit, :update, :destroy]

  def index
    conditions = Condition.where(user_id: params[:user_id]).order(:date)
    @date = Time.current
    search_date = Time.current
    @conditions = conditions.where(date: search_date.in_time_zone.all_day)

    condition_graph
  end

  def index_ago1
    conditions = Condition.where(user_id: params[:user_id]).order(:date)
    @date = Time.current.ago(1.days)
    search_date = Time.current.ago(1.days)
    @conditions = conditions.where(date: search_date.in_time_zone.all_day)
    condition_graph
    render 'index'
  end

  def index_ago2
    conditions = Condition.where(user_id: params[:user_id]).order(:date)
    @date = Time.current.ago(2.days)
    search_date = Time.current.ago(2.days)
    @conditions = conditions.where(date: search_date.in_time_zone.all_day)
    condition_graph
    render 'index'
  end

  def index_ago3
    conditions = Condition.where(user_id: params[:user_id]).order(:date)
    @date = Time.current.ago(3.days)
    search_date = Time.current.ago(3.days)
    @conditions = conditions.where(date: search_date.in_time_zone.all_day)
    condition_graph
    render 'index'
  end

  def index_ago4
    conditions = Condition.where(user_id: params[:user_id]).order(:date)
    @date = Time.current.ago(4.days)
    search_date = Time.current.ago(4.days)
    @conditions = conditions.where(date: search_date.in_time_zone.all_day)
    condition_graph
    render 'index'
  end

  def index_ago5
    conditions = Condition.where(user_id: params[:user_id]).order(:date)
    @date = Time.current.ago(5.days)
    search_date = Time.current.ago(5.days)
    @conditions = conditions.where(date: search_date.in_time_zone.all_day)
    condition_graph
    render 'index'
  end

  def index_ago6
    conditions = Condition.where(user_id: params[:user_id]).order(:date)
    @date = Time.current.ago(6.days)
    search_date = Time.current.ago(6.days)
    @conditions = conditions.where(date: search_date.in_time_zone.all_day)
    condition_graph
    render 'index'
  end

  def index_ago7
    conditions = Condition.where(user_id: params[:user_id]).order(:date)
    @date = Time.current.ago(7.days)
    search_date = Time.current.ago(7.days)
    @conditions = conditions.where(date: search_date.in_time_zone.all_day)
    condition_graph
    render 'index'
  end

  def new
    @condition = Condition.new
  end

  def create
    @condition = Condition.new(condition_params)
    if @condition.save
      flash[:success] = "体調を送信しました!"
      redirect_to user_conditions_path(current_user)
    else
      flash.now[:danger] = "体調を入力してください"
      render 'new'
    end
  end

  def edit
    @condition = Condition.find(params[:id])
  end

  def show
    @condition = Condition.find(params[:id])
  end

  def destroy
    @condition = Condition.find(params[:id])
    @condition.destroy
    flash[:danger] = "体調を削除しました"
    redirect_to user_conditions_path(current_user)
  end

  def update
    @condition = Condition.find(params[:id])
    if @condition.update (condition_params)
      flash[:success] = "体調を編集しました!"
      redirect_to user_conditions_path(current_user)
    else
      flash.now[:danger] = "体調を入力してください"
      render 'edit'
    end
  end

  def condition_graph
    gon.bardata = []
    gon.linedata = []
    @graphtimes =  @conditions.order(date: "DESC")
    @graphtimes.each do |graphtime|
      data = graphtime.level
      gon.bardata << data
      gon.linedata << data
    end
    gon.timedata = []
    @timedatas =  @conditions.order(date: "DESC")
    @timedatas.each do |timedata|
      data = timedata.date.strftime("%H時").to_s
      gon.timedata << data
    end
    gon.memo = []
    @graphmemos =  @conditions.order(date: "DESC")
    @graphmemos.each do |graphmemo|
      data = graphmemo.memo
      gon.memo << data
    end
  end


  private

    def condition_params
      params.require(:condition).permit(:level, :date, :memo).merge(user_id: current_user.id)
    end

    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
