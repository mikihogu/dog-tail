class Admin::PostsController < ApplicationController
  def index
    @categories = Category.all
    @posts = Post.all.order(created_at: :desc)
    if params[:category]
      @category = Category.find_by(name: params[:category])
      @posts = @category.posts.order(created_at: :desc)
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to :index
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
