class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    # 並べ替え
    if params[:old]
      @posts = Post.old.page(params[:page]).per(10)
    elsif params[:latest]
      @posts = Post.latest.page(params[:page]).per(10)
    elsif params[:most_favorited]
      posts = Post.most_favorited
      @posts = Kaminari.paginate_array(posts).page(params[:page]).per(10)
    else
      @posts = Post.all.order(created_at: :desc).page(params[:page]).per(10)
    end

    # 会員ごとの投稿一覧表示のため
    if params[:member_id]
      @posts = Post.where(member_id: params[:member_id]).page(params[:page]).per(10)
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to admin_posts_path, notice: "投稿1件を削除しました"
    else
      redirect_to request.referer
    end
  end

  private
  def post_params
    params.require(:post).permit(
      :name, :introduction, :information, :post_image,
      :category_id,
      :prefecture, :address, :latitude, :longitude, tag_ids: []
    )
  end

end
