class Public::NotificationsController < ApplicationController

  def index
    # @notifications = current_member.passive_notifications.page(params[:page]).per
    @notifications = current_member.passive_notifications

    # @notifications.where(checked: false).each do |notification|
      # notification.update(checked: true)
    # end
  end

end
