class SlideshowsController < ApplicationController
  def index
    @slideshows = Slideshow.search(params[:page])
  end
  
  def show
    @slideshow = Slideshow.find(params[:id])
    session[:slideshow] = @slideshow
    session[:slide_index] = 0
    @slide = @slideshow.slides[0]
  end
  
  def edit
    @slideshow = Slideshow.find(params[:id])
    session[:slideshow] = @slideshow
    @photos = unused_photos(@slideshow)
    @all_categories = Category.find(:all, :order => "name")
  end
  
  def unused_photos(slideshow)
    category_id = session[:category_id] || 1
    session[:category_id] = category_id
    category = Category.find(category_id)
    all_photos = category.photos_including_child_categories
    candidates = []
    for photo in all_photos
       in_slideshow = false
       for slide in slideshow.slides
         if slide.photo.thumbnail === photo.thumbnail
            in_slideshow = true
            break
          end
       end
       candidates << photo if not in_slideshow
    end
    return candidates
  end

  def update_slide_order
    params[:sortable_thumbs].each_with_index do |id, position|
      Slide.update(id, :position => position)
    end
  end
  
  def remove_slide
    slideshow_id = session[:slideshow].id
    slide_id = params[:id].split("_")[1]
    Slide.delete(slide_id)
    @slideshow = Slideshow.find(slideshow_id)
    session[:slideshow] = @slideshow
    @photos = unused_photos(@slideshow)
    render :partial => "photo_picker"
  end
  
  def update_slide_order
    params[:sortable_thumbs].each_with_index do |id, position|
      Slide.update(id, :position => position)
    end
  end
  
  def show_slide
    @slideshow = session[:slideshow]
    session[:slide_index] += 1
    @slide = @slideshow.slides[session[:slide_index]]
    if @slide == nil
      session[:slide_index] = 0
      @slide = @slideshow.slides[0]
    end
    render :partial => "show_slide"
  end
  
  def add_photo
    slideshow_id = session[:slideshow].id
    photo_id = params[:id].split("_")[1]
    slide = Slide.new()
    slide.photo_id = photo_id
    slide.slideshow_id = slideshow_id
    if !slide.save
      flash[:notice] = 'Error: Unable to add photo.'
    end
    @slideshow = Slideshow.find(slideshow_id)
    session[:slideshow] = @slideshow
    render :partial => "show_slides_draggable"
  end
  
  def change_filter
    slideshow_id = session[:slideshow].id
    category_id = params[:category_id] || 1
    session[:category_id] = category_id
    @slideshow = Slideshow.find(slideshow_id)
    session[:slideshow] = @slideshow
    @photos = unused_photos(@slideshow)
    render :partial => "photo_picker"
  end
end
