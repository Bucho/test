class PhotosController < ApplicationController
  def index
    @photos = Photo.find(:all)    
  end
  
  def show
    @photo = Photo.find(params[:id])
  end
  
  def new
    @photo = Photo.new
    @all_categories = Category.find(:all, :order=>"name")
    @selected = []
  end
  
  def create
    @photo = Photo.new(params[:photo])
    @photo.categories = Category.find(params[:categories]) if params[:categories]
    if @photo.save
      flash[:notice] = "Photo was suceffuly created"
      redirect_to :action => :index
    else
      @all_categories = Category.find(:all, :order=>"name")
      render :action => :new
    end
  end
  
  def edit
    @photo = Photo.find(params[:id])
    @all_categories = Category.find(:all, :order=>"name")
    @selected = @photo.categories.collect { |cat| cat.id.to_i }
  end
  
  def update
    @photo = Photo.find(params[:id])
    @photo.categories = Category.find(params[:categories]) if params[:categories]
    if @photo.update_attributes(params[:photo])
      flash[:notice] = "Photo was updated"
      redirect_to :action => :show, :id => @photo
    else
      render :action => :edit
      end
  end
  
  def destroy
    Photo.find(params[:id]).destroy
    redirect_to :action => :index
  end
 end
