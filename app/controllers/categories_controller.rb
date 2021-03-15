class CategoriesController < ApplicationController
  before_action :set_category, only: %i[edit update show destroy]
  before_action :require_admin, except: %i[index show]
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

  def edit; end

  def update
    if @category.update(category_params)
      flash[:notice] = 'The category has been successfully updated.'
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end

  def show
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    unless logged_in? && current_user.admin?
      flash[:notice] = 'Only admins can perform that action'
      redirect_to categories_path
    end
  end
end
