class CategoriesController < ApplicationController
  def index
    @categories = Category.all.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Category has been successfully created.'
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def show; end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
