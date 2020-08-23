class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @post = current_user.microposts.build
      @condition = current_user.conditions.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
  def help
  end
  def icon
    @post = current_user.microposts.build if logged_in?
  end
  def contact
  end
end
