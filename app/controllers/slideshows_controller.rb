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
  end
  
  def unused_photos(slideshow)
    all_photos = Photo.find(:all)
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
    render_partial 'photo_picker'
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
end
