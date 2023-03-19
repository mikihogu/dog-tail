class Public::PostsController < ApplicationController
  before_action :authenticate_member!, except: [:index]

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
      flash.now[:alert] = '投稿に失敗しました'
      render :new
    end
  end

  def index
    @categories = Category.all

    # タブ表示(カテゴリー別or全件)
    if params[:category]
      @category = Category.find_by(name: params[:category])
      @posts = @category.posts.page(params[:page])
    else
      @posts = Post.all.page(params[:page])
    end
    # 並べ替え  #三項演算子
    @posts = params[:condition] ? @posts.send(params[:condition]) : @posts.order(created_at: :desc)
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
