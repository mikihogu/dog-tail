class Public::InterestsController < ApplicationController
  def index
    interests = Interest.where(member_id: current_member.id).pluck(:post_id)
    @interest_posts = Post.find(interests)
    @categories = Category.all
    @posts = Post.all # 空のオブジェクト生成
    # byebug
    if params[:category]
      # byebug
      @category = Category.find_by(name: params[:category])
      @interest_posts = @category.posts.where(id: interests)
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
