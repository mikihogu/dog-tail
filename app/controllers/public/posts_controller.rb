class Public::PostsController < ApplicationController
  before_action :authenticate_member!, except: [:index]
  before_action :ensure_correct_member, only: [:edit, :update]

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
      @posts = @category.posts
    else
      @posts = Post.all
    end

    # 並べ替え  #三項演算子
    @posts = params[:condition] ? @posts.send(params[:condition]) : @posts.order(created_at: :desc)
    if params[:condition] == "most_favorited"
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(8)
    else
      @posts = @posts.page(params[:page]).per(8)
    end
    
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    if params[:show_all]
      @comments = @post.comments.order(created_at: :desc).page(params[:page]).per(10)
    else
      @comments = @post.comments.order(created_at: :desc).limit(10)
      @comments = Kaminari.paginate_array(@comments).page(params[:page]).per(11)
    end
    # ページネーション非同期のための記述
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @post = Post.find(params[:id])
    @categories = Category.all
    @tags = Tag.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      @post.update(updated_at: Time.current)
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

  def ensure_correct_member
    @post = Post.find(params[:id])
    unless @post.member == current_member
      redirect_to post_path(@post)
    end
  end
  
end
