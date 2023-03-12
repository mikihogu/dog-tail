class Public::CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.member_id = current_member.id
    @comment.post_id = @post.id
    if @comment.save
      redirect_to request.referer
    else
      redirect_to request.referer, flash[:notice]='Failed'
    end
  end

  def destroy
    @post.comment = Post.comment.find(params[:id])
    @post.comment.destroy
    redirect_to request.referer
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end

end
