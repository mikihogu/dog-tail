class Public::MembersController < ApplicationController
  def show
  end
  


  private
  def member_params
    params.require(:member).permit(:name, :nickname, :password, :email, :image, :dog, :introduction, dog_images: [])
  end
end
