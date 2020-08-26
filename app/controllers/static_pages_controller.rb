class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @post = current_user.microposts.build
      @condition = current_user.conditions.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
  def icon
    @post = current_user.microposts.build if logged_in?
    @condition = current_user.microposts.build if logged_in?
  end
  def guest_login
    @user = User.new
    @user.email = 'guest@gmail.com'
    @user.password = '123456'
    render 'sessions/guest_login'
  end
end
