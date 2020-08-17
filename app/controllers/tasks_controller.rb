class TasksController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user

  def index
    @tasks = Task.where(user_id: current_user).order(state: "DESC").order('limit_date')
  end

  
  def new
    @task = Task.new
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = "タスクを送信しました!"
      redirect_to user_tasks_path(current_user)
    else
      flash.now[:danger] = "体調を入力してください"
      render 'new'
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = "タスクを編集しました!"
      redirect_to user_tasks_path(current_user)
    else
      flash.now[:danger] = "タスクを入力してください"
      render 'edit'
    end
  end
  def push
    @task = Task.find(params[:id])
    if @task.state == 'todo'
      @task.update(state: 'doing')
    elsif @task.state == 'doing'
      @task.update(state: '-')
    end
    redirect_to user_tasks_path(current_user)
  end
  def check
    @task = Task.find(params[:id])
    if @task.state == '-'
      @task.update(state: 'todo')
    else
      @task.update(state: '-')
    end
    redirect_to user_tasks_path(current_user)
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:danger] = "タスクを削除しました"
    redirect_to user_tasks_path(current_user)
  end

    private

    def task_params
      params.require(:task).permit(:state, :task, :memo, :limit_date, :color).merge(user_id: current_user.id)
    end
    
    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
