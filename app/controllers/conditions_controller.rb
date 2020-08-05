class ConditionsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:create, :new, :edit, :update, :destroy]


  def index
    @conditions = Condition.where(params[:user_id]).order(:date)
    search_date = Time.current
    @day_conditions = @conditions.where(date: search_date.in_time_zone.all_day)

    gon.bardata = []
    gon.linedata = []
    @graphtimes =  @day_conditions.order(date: "DESC")
    @graphtimes.each do |graphtime|
      data = graphtime.level
      gon.bardata << data
      gon.linedata << data
    end

    gon.timedata = []
    @timedatas =  @day_conditions.order(date: "DESC")
    @timedatas.each do |timedata|
      data = timedata.date.strftime("%H時").to_s
      gon.timedata << data
    end

    
    # day_end = Time.current.end_of_day
    # conditions = @conditions.where(date: day_start..day_end)

    # gon.bardata = []
    # gon.linedata = []
    # @graphtimes =  conditions.order(date: "DESC").reverse
    # @graphtimes.each do |graphtime|
    #   data = graphtime.level
    #   gon.bardata << data
    #   gon.linedata << data
    # end

    # gon.timedata = []
    # @timedatas =  conditions.order(date: "DESC").reverse
    # @timedatas.each do |timedata|
    #   data = timedata.date.strftime("%m月%d日　%H時%M分").to_s
    #   gon.timedata << data
    # end


    # @graphdays =  @conditions.order(created_at: "DESC").limit(6).reverse
    # @dayline = Array.new
    # @graphdays.each do |graphday|
    #     @dayline.push(graphday.created_at.strftime('%d %H:%M').to_s)
    # end
    # @graphtimes =  @user.sports.order(sport_day: "DESC").limit(6).reverse
    # @timeline = Array.new
    # @graphtimes.each do |graphtime|
    #     @timeline.push(graphtime.sport_time)
    # end


    # gon.graphdays = []
    # gon.graphtimes = []

    # @graphdays =  @conditions.order(created_at: "DESC").limit(6).reverse
    # @dayline = Array.new
    # @graphdays.each do |graphday|
    #   @dayline.push(graphday.created_at.strftime('%d %H:%M').to_s)
    # end
    # data = @dayline
    # gon.graphdays << data
    
    # @graphtimes =  @conditions.order(created_at: "DESC").limit(6).reverse
    # @timeline = Array.new
    # @graphtimes.each do |graphtime|
    #   @timeline.push(graphtime.level)
    # end
    # data =@timeline
    # gon.graphtimes << data
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
      render 'edit'
    end
  end


  private

    def condition_params
      params.require(:condition).permit(:level, :date).merge(user_id: current_user.id)
    end

    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
