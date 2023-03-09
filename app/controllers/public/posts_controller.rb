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
    @post.member_id = current_member.id
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end   
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end


  private
  def post_params
    params.require(:post).permit(:name, :introduction, :information, :post_image, :category, :category_id, {tags: []}, {tag_ids: []}, :prefecture, :address)
  end

end
