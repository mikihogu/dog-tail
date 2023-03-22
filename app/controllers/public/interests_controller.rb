class Public::InterestsController < ApplicationController
  before_action :authenticate_member!

  def index
    interests = Interest.where(member_id: current_member.id).pluck(:post_id)
    @interest_posts = Post.where(id: interests).page(params[:page]).per(12)
    @categories = Category.all
    if params[:category]
      @category = Category.find_by(name: params[:category])
      @interest_posts = @category.posts.where(id: interests).page(params[:page]).per(12)
    end
    # 並べ替え  #三項演算子
    @interest_posts = params[:condition] ? @interest_posts.send(params[:condition]) : @interest_posts.order(created_at: :desc)
    if params[:condition] == "most_favorited"
      @interest_posts = Kaminari.paginate_array(@interest_posts).page(params[:page]).per(8)
    end
  end

  def create
    @post = Post.find(params[:post_id])
    interest = current_member.interests.new(post_id:@post.id)
    interest.save
    # redirect_to request.referer
  end

  def destroy
    @post = Post.find(params[:post_id])
    interest = current_member.interests.find_by(post_id:@post.id)
    interest.destroy
    # redirect_to request.referer
  end

end
