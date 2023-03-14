class Public::NotificationsController < ApplicationController

  def index
    if params[:filter] == "unchecked"
      @notifications = current_member.passive_notifications.where(checked: false)
    else
      @notifications = current_member.passive_notifications
    end
  end

  def show
    @notification = Notification.find(params[:id])
    @comment = @notification.comment
    @post = @notification.post
    @notification.update(checked: true)
  end

end
