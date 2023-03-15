class Admin::CategoriesController < ApplicationController

  def create
    @category = Category.new(category_params)
    @categories = Category.all
    @category.save
  end

  def index
    @categories = Category.all
    @category = Category.new
  end

  def destroy
    @categories = Category.all
    @category = Category.find(params[:id])
    @category.destroy
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

end
