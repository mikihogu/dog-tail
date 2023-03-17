class Public::PostsController < ApplicationController
  def new
    @post = Post.new
    @posts = Post.all
    @categories = Category.all
    @tags = Tag.all
  end

  def create
    @categories = Category.all
    @tags = Tag.all
    @post = Post.new(post_params)
    @post.latitude = params[:post][:latitude]
    @post.longitude = params[:post][:longitude]
    @post.member_id = current_member.id
    @post.tags = Tag.where(id: params[:post][:tag_ids])
    if @post.save
      redirect_to post_path(@post), notice: "この施設情報を投稿しました"
    else
      flash.now[:alert] = 'There was something wrong.'
      render :new
    end
  end

  def index
    @categories = Category.all
    @posts = Post.all.order(created_at: :desc)
    if params[:category]
      @category = Category.find_by(name: params[:category])
    end

    # 並べ替え
    @posts = params[:category] ? @category.posts : Post.all #三項演算子
    @posts = @posts.send(params[:condition]) if params[:condition]
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
    @categories = Category.all
    @tags = Tag.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿内容を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "1件の投稿を削除しました"
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
