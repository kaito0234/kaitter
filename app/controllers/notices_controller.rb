class NoticesController < ApplicationController
  
  def index
    @notices = current_user.passive_notices.paginate(page: params[:page])
    @notices.where(checked: false).each do |notice|
      notice.update_attributes(checked: true)
    end
  end
end
