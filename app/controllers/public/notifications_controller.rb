class Public::NotificationsController < ApplicationController

  def index
    @notifications = Notification.joins(:post).where(posts: { member_id: current_member.id }, checked: false)

  end

end
