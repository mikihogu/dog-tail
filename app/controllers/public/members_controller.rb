class Public::MembersController < ApplicationController
  before_action :authenticate_member!

  def show
    @member = Member.find(params[:id])
    if params[:show_all]
      @posts = @member.posts
      # @posts = @member.posts.page(params[:page]).per(4)
    else
      @posts = @member.posts.limit(3)
    end
    # ブックマーク施設表示
    interests = Interest.where(member_id: current_member.id).pluck(:post_id)
    @interest_posts = Post.where(id: interests).limit(5)
  end

  def edit
    @member = current_member
  end

  def update
    @member = current_member
    if params[:member][:dog_images_ids]
      params[:member][:dog_images_ids].each do |dimage_id|
        dimage = member.dog_images.find(dimage_id)
        dimage.purge
      end
    end
    if @member.update(member_params)
      redirect_to member_path(@member), notice: "会員情報を更新しました"
    else
      render :edit
    end
  end

  private
  def member_params
    params.require(:member).permit(:name, :nickname, :password, :email, :image, :dog, :introduction, dog_images: [])
  end
end
