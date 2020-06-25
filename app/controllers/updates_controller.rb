class UpdatesController < ApplicationController

  def index
    @updates = Update.all.order(created_at: 'desc')
  end

  def new
    @update = Update.new
  end

  def create
    admin_user
    @update = Update.new(update_params)
    if @update.save
      redirect_to updates_path
    else
      render 'new'
    end
  end

  def edit
    admin_user
    @update = Update.find(params[:id])
  end

  def show
     @update = Update.find(params[:id])
  end

  def destroy
    admin_user
    @update = Update.find(params[:id])
    @update.destroy
    redirect_to updates_path
  end

  def update
    admin_user
    @update = Update.find(params[:id])
    if @update.update (update_params)
      redirect_to update_path
    else
      render 'edit'
    end
  end


  private

    def update_params
      params.require(:update).permit(:title, :text)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
