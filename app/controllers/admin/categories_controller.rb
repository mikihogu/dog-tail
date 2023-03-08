class Admin::CategoriesController < ApplicationController

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to request.referer
    else
      render :index
    end
  end

  def index
    @categories = Category.all
    @category = Category.new
  end

  def destroy
    @category = Category.find(parama[:id])
    if @category.destroy
      redirect_to request.referer
    else
      render :index
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

end
