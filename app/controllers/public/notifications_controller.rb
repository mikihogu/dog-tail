class Public::NotificationsController < ApplicationController

  def index
    # @notifications = current_member.passive_notifications.page(params[:page]).per
    @notifications = current_member.passive_notifications
    # @notifications.where(checked: false).each do |notification|
      # notification.update(checked: true)
    # end
  end

  def show
    # visited_id == current_member.id
    # @notification = Notification.find(params[:id])
    # @comment = Comment.find(params[:comment_id])
    #   comment.notification.update(checked: true)
    # end
    # @notification = Notification.find(params[:id])
    # @post = @notification.comment.post
    # @comment = @notification.comment

    @notification = Notification.find(params[:id])
    @comment = @notification.comment
    @post = @notification.post
    @notification.update(checked: true)
  end
end
