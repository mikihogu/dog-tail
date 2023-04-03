class Public::CommentsController < ApplicationController
  before_action :authenticate_member!, except: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.member_id = current_member.id
    @comment.post_id = @post.id
    @comment.save
    @comments = @post.comments.order(created_at: :desc).page(params[:page]).per(10)
    @post.create_notification_comment!(current_member, @comment.id) #通知する
  end

  def destroy
    #findからfind_byに変更して,ボタン連打で見つからない場合を考慮
    @comment = Comment.find_by(id:params[:id])
    @post = Post.find(params[:post_id])
    #destroyメソッドもifをつけておく
    @comment.destroy if @comment
    @comments = Comment.where(post_id: @post.id).order(created_at: :desc)
    if @comments.count % 10 == 0 && @comments.count / 10 == params[:page].to_i - 1
      params[:page] = (params[:page].to_i - 1)
    end
    #kaminariのper(10)からその倍数で割れるコメント数の時にJS用のフラグを立てる
    @_destroy = @comments.count % 10 == 0
    #その後page(params[:page])をしないと全体のコメント数がみられない
    @comments = @comments.page(params[:page]).per(10)
    #js.erbにparamatorを送る
    @page = params[:page]
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end

end
