class CategoriesController < ApplicationController
  
  def index
    @all_categories = Category.find(:all, :order=>"name")
  end
  
  def new
    @category = Category.new
    @all_categories = Category.find(:all, :order=>"name")
  end
  
  def edit
    @category = Category.find(params[:id])
    @all_categories = Category.find(:all, :order=>"name")
  end
  
end
