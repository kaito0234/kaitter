class ConditionsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:create, :new, :edit, :update, :destroy]

  def index
    @date = Time.current
    condition_day
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

  def index_ago1
    @date = Time.current.ago(1.days)
    condition_day
    render 'index'
  end
  def index_ago2
    @date = Time.current.ago(2.days)
    condition_day
    render 'index'
  end
  def index_ago3
    @date = Time.current.ago(3.days)
    condition_day
    render 'index'
  end
  def index_ago4
    @date = Time.current.ago(4.days)
    condition_day
    render 'index'
  end
  def index_ago5
    @date = Time.current.ago(5.days)
    condition_day
    render 'index'
  end
  def index_ago6
    @date = Time.current.ago(6.days)
    condition_day
    render 'index'
  end
  def index_ago7
    @date = Time.current.ago(7.days)
    condition_day
    render 'index'
  end

  def index_week
    @date = Time.current.beginning_of_week
    week_avg
  end
  def index_1week
    @date = Time.current.ago(1.week).beginning_of_week
    week_avg
    render 'index_week'
  end
  def index_2week
    @date = Time.current.ago(2.week).beginning_of_week
    week_avg
    render 'index_week'
  end
  def index_3week
    @date = Time.current.ago(3.week).beginning_of_week
    week_avg
    render 'index_week'
  end
  def index_4week
    @date = Time.current.ago(4.week).beginning_of_week
    week_avg
    render 'index_week'
  end

  def index_month
    @date = Time.current.beginning_of_month
    month_avg
  end
  def index_1month
    @date = Time.current.ago(1.month).beginning_of_month
    month_avg
    render 'index_month'
  end
  def index_2month
    @date = Time.current.ago(2.month).beginning_of_month
    month_avg
    render 'index_month'
  end
  def index_3month
    @date = Time.current.ago(3.month).beginning_of_month
    month_avg
    render 'index_month'
  end
  def index_4month
    @date = Time.current.ago(4.month).beginning_of_month
    month_avg
    render 'index_month'
  end
  def index_5month
    @date = Time.current.ago(5.month).beginning_of_month
    month_avg
    render 'index_month'
  end
  def index_6month
    @date = Time.current.ago(6.month).beginning_of_month
    month_avg
    render 'index_month'
  end

  def condition_day
    conditions = Condition.where(user_id: params[:user_id]).order(:datetime)
    @conditions = conditions.where(datetime: @date.in_time_zone.all_day)
    gon.bardata = []
    gon.linedata = []
    @graphtimes =  @conditions.order(datetime: "DESC")
    @graphtimes.each do |graphtime|
      data = graphtime.level
      gon.bardata << data
      gon.linedata << data
    end
    gon.timedata = []
    @timedatas =  @conditions.order(datetime: "DESC")
    @timedatas.each do |timedata|
      data = timedata.datetime.strftime("%H時").to_s
      gon.timedata << data
    end
    gon.memo = []
    @graphmemos =  @conditions.order(datetime: "DESC")
    @graphmemos.each do |graphmemo|
      data = graphmemo.memo
      gon.memo << data
    end
  end

  # @conditions_avg = @conditions.group("date(datetime)").order(:date_datetime).average(:level)
  def week_avg
    if Rails.env.development?  # 開発時用の処理 SQlite
      @conditions = Condition.where(user_id: params[:user_id]).where(datetime: @date.in_time_zone.all_week).order(:datetime)
      @conditions_avg = @conditions.group("DATE(datetime, 'localtime')").average(:level)
    end
    if Rails.env.production?  # 本番環境用の処理 PostgreSQL
      @conditions = Condition.where(user_id: params[:user_id]).where(datetime: @date.in_time_zone.all_week)
      @conditions_avg = @conditions.group("DATE(datetime AT TIME ZONE 'UTC' AT TIME ZONE 'Japan')").order(:date_datetime_at_time_zone_utc_at_time_zone_japan).average(:level)
    end
    gon.bardata = []
    gon.linedata = []
    @graphtimes = @conditions_avg
    @graphtimes.each do |graphtime|
      data = graphtime[1]
      gon.bardata << data
      gon.linedata << data
    end
    gon.timedata = []
    @timedatas = @conditions_avg
    @timedatas.each do |timedata|
      data = timedata[0]
      gon.timedata << data
    end
  end

  def month_avg
    if Rails.env.development?  # 開発時用の処理 SQlite
      @conditions = Condition.where(user_id: params[:user_id]).where(datetime: @date.in_time_zone.all_month).order(:datetime)
      @conditions_avg = @conditions.group("date(datetime, 'localtime')").average(:level)
    end
    if Rails.env.production?  # 本番環境用の処理 PostgreSQL
      @conditions = Condition.where(user_id: params[:user_id]).where(datetime: @date.in_time_zone.all_month)
      @conditions_avg = @conditions.group("DATE(datetime AT TIME ZONE 'UTC' AT TIME ZONE 'Japan')").order(:date_datetime_at_time_zone_utc_at_time_zone_japan).average(:level)
    end
    gon.bardata = []
    gon.linedata = []
    @graphtimes = @conditions_avg
    @graphtimes.each do |graphtime|
      data = graphtime[1]
      gon.bardata << data
      gon.linedata << data
    end
    gon.timedata = []
    @timedatas = @conditions_avg
    @timedatas.each do |timedata|
      data = timedata[0]  
      gon.timedata << data
    end
  end

  private

    def condition_params
      params.require(:condition).permit(:level, :datetime, :memo).merge(user_id: current_user.id)
    end

    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
