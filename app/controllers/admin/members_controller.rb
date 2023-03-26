class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    #並べ替え  #三項演算子
    @members = Member.all
    @members = params[:condition] ? @members.send(params[:condition]) : @members.order(created_at: :desc)
    if params[:condition] == "most_favorited"
      @members = Kaminari.paginate_array(@members).page(params[:page]).per(10)
    else
      @members = @members.page(params[:page]).per(10)
    end
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
