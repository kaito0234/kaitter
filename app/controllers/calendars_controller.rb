class CalendarsController < ApplicationController
  before_action :logged_in_user

  def index
    @calendars = Calendar.all
  end

  def new

  end
  
  def show
    @calendar = Calendar.where(user_id: current_user.id)
  end

  def edit
  end

  def create
  end

  def destroy
  end

  def update
  end


end
