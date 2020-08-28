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

  # def index_week
  #   conditions = Condition.where(user_id: params[:user_id]).order(:date)
  #   @date = Time.current.beginning_of_week
  #   search_date = Time.current.beginning_of_week
  #   @conditions = conditions.where(date: search_date.in_time_zone.all_week)
  #   condition_graph_week
  # end
  # def index_1week
  #   conditions = Condition.where(user_id: params[:user_id]).order(:date)
  #   @date = Time.current.ago(1.week).beginning_of_week
  #   search_date = Time.current.ago(1.week).beginning_of_week
  #   @conditions = conditions.where(date: search_date.in_time_zone.all_week)
  #   condition_graph_week
  #   render 'index_week'
  # end
  # def index_2week
  #   conditions = Condition.where(user_id: params[:user_id]).order(:date)
  #   @date = Time.current.ago(2.week).beginning_of_week
  #   search_date = Time.current.ago(2.week).beginning_of_week
  #   @conditions = conditions.where(date: search_date.in_time_zone.all_week)
  #   condition_graph_week
  #   render 'index_week'
  # end
  # def index_3week
  #   conditions = Condition.where(user_id: params[:user_id]).order(:date)
  #   @date = Time.current.ago(3.week).beginning_of_week
  #   search_date = Time.current.ago(3.week).beginning_of_week
  #   @conditions = conditions.where(date: search_date.in_time_zone.all_week)
  #   condition_graph_week
  #   render 'index_week'
  # end
  # def index_4week
  #   conditions = Condition.where(user_id: params[:user_id]).order(:date)
  #   @date = Time.current.ago(4.week).beginning_of_week
  #   search_date = Time.current.ago(4.week).beginning_of_week
  #   @conditions = conditions.where(date: search_date.in_time_zone.all_week)
  #   condition_graph_week
  #   render 'index_week'
  # end

  # def index_month
  #   conditions = Condition.where(user_id: params[:user_id]).order(:date)
  #   @date = Time.current.beginning_of_month
  #   search_date = Time.current.beginning_of_month
  #   @conditions = conditions.where(date: search_date.in_time_zone.all_month)
  #   condition_graph_week
  # end
  # def index_1month
  #   conditions = Condition.where(user_id: params[:user_id]).order(:date)
  #   @date = Time.current.ago(1.month).beginning_of_month
  #   search_date = Time.current.ago(1.month).beginning_of_month
  #   @conditions = conditions.where(date: search_date.in_time_zone.all_month)
  #   condition_graph_week
  #   render 'index_month'
  # end
  # def index_2month
  #   conditions = Condition.where(user_id: params[:user_id]).order(:date)
  #   @date = Time.current.ago(2.month).beginning_of_month
  #   search_date = Time.current.ago(2.month).beginning_of_month
  #   @conditions = conditions.where(date: search_date.in_time_zone.all_month)
  #   condition_graph_week
  #   render 'index_month'
  # end
  # def index_3month
  #   conditions = Condition.where(user_id: params[:user_id]).order(:date)
  #   @date = Time.current.ago(3.month).beginning_of_month
  #   search_date = Time.current.ago(3.month).beginning_of_month
  #   @conditions = conditions.where(date: search_date.in_time_zone.all_month)
  #   condition_graph_week
  #   render 'index_month'
  # end
  # def index_4month
  #   conditions = Condition.where(user_id: params[:user_id]).order(:date)
  #   @date = Time.current.ago(4.month).beginning_of_month
  #   search_date = Time.current.ago(4.month).beginning_of_month
  #   @conditions = conditions.where(date: search_date.in_time_zone.all_month)
  #   condition_graph_week
  #   render 'index_month'
  # end
  # def index_5month
  #   conditions = Condition.where(user_id: params[:user_id]).order(:date)
  #   @date = Time.current.ago(5.month).beginning_of_month
  #   search_date = Time.current.ago(5.month).beginning_of_month
  #   @conditions = conditions.where(date: search_date.in_time_zone.all_month)
  #   condition_graph_week
  #   render 'index_month'
  # end
  # def index_6month
  #   conditions = Condition.where(user_id: params[:user_id]).order(:date)
  #   @date = Time.current.ago(6.month).beginning_of_month
  #   search_date = Time.current.ago(6.month).beginning_of_month
  #   @conditions = conditions.where(date: search_date.in_time_zone.all_month)
  #   condition_graph_week
  #   render 'index_month'
  # end

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
  # def condition_graph_week
  #   gon.bardata = []
  #   gon.linedata = []
  #   @graphtimes =  @conditions.order(date: "DESC")
  #   @graphtimes.each do |graphtime|
  #     data = graphtime.level
  #     gon.bardata << data
  #     gon.linedata << data
  #   end
  #   gon.timedata = []
  #   @timedatas =  @conditions.order(date: "DESC")
  #   @timedatas.each do |timedata|
  #     data = timedata.date.strftime("%d日%H時").to_s
  #     gon.timedata << data
  #   end
  #   gon.memo = []
  #   @graphmemos =  @conditions.order(date: "DESC")
  #   @graphmemos.each do |graphmemo|
  #     data = graphmemo.memo
  #     gon.memo << data
  #   end
  # end

  def week_avg
    @conditions = Condition.where(user_id: params[:user_id]).where(date: @date.in_time_zone.all_week)
    @conditions_avg = @conditions.group("date(date)").order(:date_date).average(:level)
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
    @conditions = Condition.where(user_id: params[:user_id]).where(date: @date.in_time_zone.all_month)
    @conditions_avg = @conditions.group("date(date)").order(:date_date).average(:level)
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
      params.require(:condition).permit(:level, :date, :memo).merge(user_id: current_user.id)
    end

    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
