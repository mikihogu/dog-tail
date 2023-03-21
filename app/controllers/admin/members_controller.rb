class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @members = Member.all.page(params[:page]).per(10)
  end

  def show
    @member = Member.find(params[:id])
    @posts = @member.posts.limit(5)

  end

  def update
    @member = Member.find(params[:id])
    @member.update(member_params)
    redirect_to request.referer
  end

  private
  def member_params
    params.require(:member).permit(:name, :nickname, :password, :email, :image, :dog, :introduction, :is_deleted, dog_images: [])
  end
end
