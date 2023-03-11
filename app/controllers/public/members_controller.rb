class Public::MembersController < ApplicationController
  before_action :authenticate_member!

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = current_member
  end

  def update
    @member = current_member
    if params[:member][:dog_image_ids]
      params[:member][:dog_image_ids].each do |dimage_id|
        image = post.dog-images.find(dimage_id)
        image.purge
      end
    end
    if @member.update(member_params)
      redirect_to member_path(@member)
    else
      render :edit
    end
  end

  private
  def member_params
    params.require(:member).permit(:name, :nickname, :password, :email, :image, :dog, :introduction, dog_images: [])
  end
end
