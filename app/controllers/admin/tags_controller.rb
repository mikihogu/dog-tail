class Admin::TagsController < ApplicationController
  def create
    @tag = Tag.new(tag_params)
    @tags = Tag.all
    @tag.save
  end

  def index
    @tags = Tag.all
    @tag = Tag.new
  end

  def destroy
    @tags = Tag.all
    @tag = Tag.find(params[:id])
    @tag.destroy
  end

  private
  def tag_params
    params.require(:tag).permit(:name)
  end

end
