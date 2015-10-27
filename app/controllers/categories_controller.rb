class CategoriesController < ApplicationController
  before_action :find_category, only: [:show]

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to posts_path, notice: 'Your category has been created.'
    else
      flash.now[:alert] = @category.errors.full_messages
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end

  def find_category
    @category = Category.includes(:posts).find(params[:id])
  end
end
