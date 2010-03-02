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
