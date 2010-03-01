class SlideshowsController < ApplicationController
  def index
    @slideshows = Slideshow.search(params[:page])
  end
end
