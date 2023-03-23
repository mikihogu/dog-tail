class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @members = Member.all.order(created_at: :desc).page(params[:page]).per(10)
    if params[:status]
      @members = Member.status.page(params[:page]).per(10)
    elsif params[:old]
      @members = Member.old.page(params[:page]).per(10)
    elsif params[:latest]
      @members = Member.latest.page(params[:page]).per(10)
    elsif params[:nickname]
      @members = Member.nickname.page(params[:page]).per(10)
    else
      @members = Member.all.order(created_at: :desc).page(params[:page]).per(10)
    end
    
     # 並べ替え  #三項演算子
    # @members = params[:condition] ? @members.send(params[:condition]) : @members.order(created_at: :desc).page(params[:page]).per(8)
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
