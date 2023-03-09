class Admin::TagsController < ApplicationController
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to request.referer
    else
      render :index
    end
  end

  def index
    @tags = Tag.all
    @tag = Tag.new
  end

  def destroy
    @tag = Tag.find(parama[:id])
    if @tag.destroy
      redirect_to request.referer
    else
      render :index
    end
  end

  private
  def tag_params
    params.require(:tag).permit(:name)
  end

end
